Shader "Barrel/BumpDiffuse_MultiPass"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Normal ("Normal Map", 2D) = "white" {}

		_BlendTex ("Blend Texture", 2D) = "white" {}
		_BlendNormal("Blend Texture Normal Map", 2D) = "white" {}

		_LightIntensity("Light Intensity", Range(0, 20)) = 2
		_ColorMerge("Color Merge", Range(0.1, 20)) = 8
		_Blend("Blend Textures", Range(0, 1)) = 0.5
		_Tint("Tint Color",Color) = (1,1,1,1)
		_Ramp("Ramp", 2D) = "white" {}

		_ScrollSpeeds("Scroll Speeds", vector) = (-5, -20,0,0)
		_ScrollUVMain("Scroll Texture Toggle", int) = 0
		_ScrollWeb("Scroll In a Web Pattern", int) = 0

	}
		SubShader
		{
			Tags { "RenderType" = "Opaque" }
			LOD 300

			Pass
			{
				Tags{ "LightMode" = "ForwardBase" }

				Cull Back
				Lighting On

			//Blend One One
			//Blend One OneMinusDstColor
			//Blend SrcAlpha OneMinusSrcAlpha
			//Blend  SrcColor Zero
			Blend OneMinusDstColor One

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_PIXELSNAP_ON	

			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			#define PI 3.14159265359f

			struct Input
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float3 blendNormal : NORMAL;
				float2 texcoord : TEXCOORD0;
				float2 texcoord2 : TEXCOORD1;
				float2 texcoord3 : TEXCOORD2;
				float4 tangent : TANGENT;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				float2 uv2 : TEXCOORD1;
				float2 uv3 : TEXCOORD2;
				float3 lightDirection : FLOAT3;
			};

			sampler2D _MainTex;
			sampler2D _BlendTex;

			sampler2D _Normal;
			sampler2D _BlendNormal;

			sampler2D _Ramp;

			float4 _MainTex_ST;
			float4 _BlendTex_ST;
			float4 _Normal_ST;
			float4 _BlendNormal_ST;

			half _LightIntensity;
			half _ColorMerge;
			half _Blend;
			half4 _Tint;

			half4 _ScrollSpeeds;
			
			int _ScrollUVMain;
			int _ScrollWeb;

			v2f vert (Input v)
			{
				v2f o;
				TANGENT_SPACE_ROTATION;
				
				o.lightDirection = mul(rotation, ObjSpaceLightDir(v.vertex));
				o.pos = UnityObjectToClipPos(v.vertex);

				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.uv2 = TRANSFORM_TEX(v.texcoord, _Normal);
				o.uv3 = TRANSFORM_TEX(v.texcoord, _BlendNormal);

				if (_ScrollUVMain == 1)
				{
					o.uv += _ScrollSpeeds * _Time.x;
					o.uv2 += _ScrollSpeeds * _Time.x;
					o.uv3 += _ScrollSpeeds * _Time.x;
				}

				if (_ScrollWeb == 1)
				{
					o.uv = v.texcoord - 0.5f;
					o.uv2 = v.texcoord2 - 0.5f;
					o.uv3 = v.texcoord3 - 0.5f;
				}

				return o;
			}
			
			half4 frag (v2f i) : COLOR
			{
				half2 pol1 = half2(atan2(i.uv.y, i.uv.x) / (2.0f * PI), length(i.uv));
				half2 pol2 = half2(atan2(i.uv2.y, i.uv2.x) / (2.0f * PI), length(i.uv2));
				half2 pol3 = half2(atan2(i.uv3.y, i.uv3.x) / (2.0f * PI), length(i.uv3));

				half4 mainCol;
				half4 blendCol;

				half2 finalPol;

				if (_ScrollWeb == 1)
				{
									
					pol1  *= _MainTex_ST.xy;					
					pol2 *= _Normal_ST.xy;
					pol3 *= _BlendNormal_ST.xy;
					
					finalPol = lerp((pol1 + pol2)*0.5f, pol3, 0.25f);

					finalPol += _ScrollSpeeds.xy * _Time.x;

					mainCol = tex2D(_MainTex, finalPol);
					blendCol = tex2D(_BlendTex, finalPol);
					
				}
				else
				{
					mainCol = tex2D(_MainTex, i.uv);
					blendCol = tex2D(_BlendTex, i.uv);
				}

				blendCol = blendCol *_Tint;

				half4 finalCol = lerp(mainCol, blendCol, _Blend);
				
				finalCol.rgb = (floor(finalCol.rgb *_ColorMerge) / _ColorMerge);

				float3 norm = UnpackNormal(tex2D(_Normal, i.uv2));
				float3 blendNorm = UnpackNormal(tex2D(_BlendNormal, i.uv3));

				norm = norm * blendNorm;

				float3 lightColor = unity_AmbientSky;

				float lengthSq = dot(i.lightDirection, i.lightDirection);
				float atten = 1.0 / (1.0 + lengthSq);

				float diff = saturate(dot(norm, normalize(i.lightDirection)));

				diff = tex2D(_Ramp, float2(diff, 0.1));

				lightColor += _LightColor0.rgb* (diff * atten);

				finalCol.rgb =  lightColor * finalCol.rgb * _LightIntensity;
			
				return finalCol;
			}
			ENDCG
		}

			Pass
			{
				Tags{ "LightMode" = "ForwardAdd" }

				Cull Back
				Lighting On
				Blend One One

				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"
				#include "Lighting.cginc"

				struct Input
				{
					float4 vertex : POSITION;
					float3 normal : NORMAL;
					float3 blendNormal : NORMAL;
					float2 texcoord : TEXCOORD0;
					float4 tangent : TANGENT;
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float2 uv : TEXCOORD0;
					float2 uv2 : TEXCOORD1;
					float2 uv3 : TEXCOORD2;
					float3 lightDirection : FLOAT3;
				};

				sampler2D _MainTex;
				sampler2D _Normal;
				sampler2D _BlendNormal;

				float4 _MainTex_ST;
				float4 _Normal_ST;
				float4 _BlendNormal_ST;

				half4 _ScrollSpeeds;

				v2f vert(Input v)
				{
					v2f o;
					TANGENT_SPACE_ROTATION;

					o.lightDirection = mul(rotation, ObjSpaceLightDir(v.vertex));
					o.pos = UnityObjectToClipPos(v.vertex);

				#ifdef PIXELSNAP_ON
						o.pos = UnityPixelSnap(o.pos);
				#endif

					o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
					o.uv2 = TRANSFORM_TEX(v.texcoord, _Normal);
					o.uv3 = TRANSFORM_TEX(v.texcoord, _BlendNormal);

					return o;
				}

				half4 frag(v2f i) : COLOR
				{
					half4 col = tex2D(_MainTex, i.uv);

					float3 norm = UnpackNormal(tex2D(_Normal, i.uv2));
					float3 blendNorm = UnpackNormal(tex2D(_BlendNormal, i.uv3));

					norm = norm *blendNorm;

					half3 lightColor = half3(0, 0, 0);

					half lengthSq = dot(i.lightDirection, i.lightDirection);
					half atten = 1.0 / (1.0 + lengthSq * unity_LightAtten[0].z);

					half diff = saturate(dot(norm, normalize(i.lightDirection)));
					lightColor += _LightColor0.rgb* (diff * atten);

					col.rgb = lightColor * col.rgb * 2;

					return col;
				}
				ENDCG
			}
	}

	Fallback "Barrel/BumpDiffuse"
}

/* 
		half4 Texture2DGrad(sampler2D tex, half2 uv, half2 dx, half2 dy, half2 texSize)
			{	
				half2 px = texSize.x * dx;
				half2 py = texSize.y * dy;
				half lod = 0.5 * log2(max(dot(px, px), dot(py, py)));
				return tex2Dlod(tex, half4(uv, 0, lod));
			}
*/
