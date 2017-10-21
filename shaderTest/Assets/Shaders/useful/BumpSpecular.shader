Shader "Barrel/BumpSpecular"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Normal ("Normal Map", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" "LightMode"="ForwardBase" }
		LOD 100

		Pass
		{
			Cull Back
			Lighting On

			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			struct Input
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;
				float4 tangent : TANGENT;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				float2 uv2 : TEXCOORD1;
				float3 normal : NORMAL;
			};

			sampler2D _MainTex;
			sampler2D _Normal;

			float4 _MainTex_ST;
			float4 _Normal_ST;

			v2f vert (Input v)
			{
				v2f o;

				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.uv2 = TRANSFORM_TEX(v.texcoord, _Normal);
				o.normal = normalize(mul(v.normal, unity_WorldToObject));
				return o;
			}
			
			float4 frag (v2f i) : COLOR
			{
				float4 col = tex2D(_MainTex, i.uv);
				float3 norm = UnpackNormal(tex2D(_Normal, i.uv2));

				float3 ambLight = unity_AmbientSky;

				float4 lightDirection = normalize(_WorldSpaceLightPos0);
	
				float lengthSq = dot(lightDirection, lightDirection);
				float atten = 1.0 / (1.0 + lengthSq);

				float4 diff = saturate(dot(lightDirection, i.normal));
				float4 lightColor = _LightColor0 * (diff * atten);

				float4 camPosition = normalize(float4(_WorldSpaceCameraPos, 1) - i.pos);

				float4 halfVec = normalize(lightDirection + camPosition);
				float spec = pow(saturate(dot(i.normal, halfVec)), 25);

				col.rgb = (ambLight + lightColor + spec) * 2 * col.rgb;
				
				return col;
			}
			ENDCG
		}
	}

	Fallback "Diffuse"
}
