﻿Shader "Barrel/BumpSpecularV2"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Normal ("Normal Map", 2D) = "white" {}
		_LightIntensity("Light Intensity", Range(1, 10)) = 4.5
		_Color("Color", Color) = (1,1,1,1)
		_ColorIntensity("Color Intensity", Range(1, 10)) = 1.0
		_NormalIntensity("Normal Intensity", Range(1, 5 )) = 1 
		_SpecularPower("Specular Power", Range(1, 30)) = 1
		_Saturation("Saturate Color", Range (1, 5 )) = 1
	}

	CGINCLUDE
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

	ENDCG

	SubShader
	{
		LOD 100
		
		Pass
		{
			Tags{ "RenderType" = "Transparent" "LightMode" = "ForwardBase" }

			Cull Back
			Lighting On
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM

			sampler2D _MainTex;
			sampler2D _Normal;

			float4 _MainTex_ST;
			float4 _Normal_ST;

			half _LightIntensity;
			half _ColorIntensity;
			half _NormalIntensity;
			half _SpecularPower;
			half _Saturation;

			fixed4 _Color;

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
				half4 col = tex2D(_MainTex, i.uv);
				float3 norm = UnpackNormal(tex2D(_Normal, i.uv2));
				norm = norm * _NormalIntensity;

				i.normal = normalize(norm + i.normal);

				fixed4 colIntense = _Color * _ColorIntensity;

				half3 ambLight = unity_AmbientSky * colIntense;

				float4 lightDirection = normalize( _WorldSpaceLightPos0);
	
				float lengthSq = dot(lightDirection, lightDirection);
				float atten = 1.0 / (1.0 + lengthSq);

				float4 diff = saturate(dot(lightDirection, i.normal));
				float4 lightColor = _LightColor0 *(diff * atten);

				float4 camPosition = normalize(float4(_WorldSpaceCameraPos, 1) - i.pos);

				float4 halfVec = normalize( lightDirection + camPosition);
				float spec = pow(saturate(dot(i.normal, halfVec)), 25);

				col.rgb = (ambLight  + (lightColor + spec * _SpecularPower )) * col.rgb;

				half4 colConstVec = half4(0.2125, 0.7154, 0.0721, col.a);

				half4 intensity = half4(dot(col.rgb, colConstVec), 0, 0, 0);

				half4 finalCol = lerp(intensity, col, _Saturation) * _LightIntensity;
				
				return finalCol;
			}
			ENDCG
		}	
}

	Fallback "Diffuse"
}
