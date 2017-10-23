Shader "Barrel/BumpDiffuse"
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
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
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
				float3 lightDirection : FLOAT3;
			};

			sampler2D _MainTex;
			sampler2D _Normal;

			float4 _MainTex_ST;
			float4 _Normal_ST;

			v2f vert (Input v)
			{
				v2f o;
				TANGENT_SPACE_ROTATION;
				
				o.lightDirection = mul(rotation, ObjSpaceLightDir(v.vertex));
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.uv2 = TRANSFORM_TEX(v.texcoord, _Normal);
				return o;
			}
			
			float4 frag (v2f i) : COLOR
			{
				float4 col = tex2D(_MainTex, i.uv);
				float3 norm = UnpackNormal(tex2D(_Normal, i.uv2));

				float3 lightColor = UNITY_LIGHTMODEL_AMBIENT.xyz;

				float lengthSq = dot(i.lightDirection, i.lightDirection);
				float atten = 1.0 / (1.0 + lengthSq);

				float diff = saturate(dot(norm, normalize(i.lightDirection)));
				lightColor += _LightColor0.rgb* (diff * atten);

				col.rgb =  lightColor * col.rgb * 2;
				
				return col;
			}
			ENDCG
		}
	}

	Fallback "Diffuse"
}
