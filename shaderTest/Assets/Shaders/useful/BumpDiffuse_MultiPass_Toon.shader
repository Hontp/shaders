Shader "Barrel/BumpDiffuse_MultiPass_Toon"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Normal ("Normal Map", 2D) = "white" {}
		_Outline ("Outline", Range(0, 1)) = 0.2
		_Ramp ("Color Ramp", 2D) = "white" {}
		_ColorMerge ("Color Merge", Range(0.1, 20)) = 8
		_ColorBorder("Border Color", Color) = (0,0,0,1)
		_LightIntensity("Light Intensity", Range(0, 5)) = 2

	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			Tags{ "LightMode" = "ForwardBase" }

			Cull Front
			Lighting Off
			ZWrite On
			
			CGPROGRAM
		
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct Input
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};
			
			struct v2f
			{
				float4 pos : POSITION;
			};

			float _Outline;
			float4 _ColorBorder;

			v2f vert(Input v)
			{
				v2f o;
				
				float4 pos = mul(UNITY_MATRIX_MV, v.vertex);
				float3 normal = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
				normal.z = -0.4;

				pos = pos + float4( normalize(normal), 0) * _Outline;

				o.pos = mul(UNITY_MATRIX_P, pos);

				return o;
			}

			float4 frag (Input v) :COLOR
			{	
				return _ColorBorder;
			}

			ENDCG
		}


		Pass
		{
			Tags{ "LightMode" = "ForwardBase" }

			Cull Back
			Lighting On
			

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
			sampler2D _Ramp;

			float4 _MainTex_ST;
			float4 _Normal_ST;

			float _ColorMerge;
			float _LightIntensity;

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
				col.rgb = (floor(col.rgb * _ColorMerge) / _ColorMerge);

				float3 norm = UnpackNormal(tex2D(_Normal, i.uv2));

				float3 lightColor = UNITY_LIGHTMODEL_AMBIENT.xyz;

				float lengthSq = dot(i.lightDirection, i.lightDirection);
				float atten = 1.0 / (1.0 + lengthSq);

				float diff = saturate(dot(norm, normalize(i.lightDirection)));
				
				diff = tex2D(_Ramp, float2(diff, 0.5));

				lightColor += _LightColor0.rgb* (diff * atten);

				col.rgb =  lightColor * col.rgb * _LightIntensity;
				
				return col;
			}
			ENDCG
		}

			Pass
			{
				Tags{ "LightMode" = "ForwardAdd" }

				Cull Back
				Lighting On
				//Blend One One
				Blend OneMinusDstColor One

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

				v2f vert(Input v)
				{
					v2f o;
					TANGENT_SPACE_ROTATION;

					o.lightDirection = mul(rotation, ObjSpaceLightDir(v.vertex));
					o.pos = UnityObjectToClipPos(v.vertex);
					o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
					o.uv2 = TRANSFORM_TEX(v.texcoord, _Normal);
					return o;
				}

				float4 frag(v2f i) : COLOR
				{
					float4 col = tex2D(_MainTex, i.uv);
					float3 norm = UnpackNormal(tex2D(_Normal, i.uv2));

					float3 lightColor = float3(0, 0, 0);

					float lengthSq = dot(i.lightDirection, i.lightDirection);
					float atten = 1.0 / (1.0 + lengthSq * unity_LightAtten[0].z);

					float diff = saturate(dot(norm, normalize(i.lightDirection)));
					lightColor += _LightColor0.rgb* (diff * atten);

					col.rgb = lightColor * col.rgb * 2;

					return col;
				}
				ENDCG
			}
	}

	Fallback "Barrel/BumpDiffuse_MultiPass"
}
