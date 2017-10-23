// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASETemplateShaders/DefaultUnlit"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_MinHeight("Min Height", Float) = 39
		_MaxHeight("Max Height", Float) = 60
		_Texture0("Texture 0", 2D) = "white" {}
		_Texture1("Texture 1", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform sampler2D _Texture0;
		uniform float4 _Texture0_ST;
		uniform sampler2D _Texture1;
		uniform float4 _Texture1_ST;

		UNITY_INSTANCING_CBUFFER_START(ASETemplateShadersDefaultUnlit)
			UNITY_DEFINE_INSTANCED_PROP(float, _MinHeight)
			UNITY_DEFINE_INSTANCED_PROP(float, _MaxHeight)
		UNITY_INSTANCING_CBUFFER_END

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float2 uv_Texture1 = i.uv_texcoord * _Texture1_ST.xy + _Texture1_ST.zw;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float _MinHeight_Instance = UNITY_ACCESS_INSTANCED_PROP(_MinHeight);
			float _MaxHeight_Instance = UNITY_ACCESS_INSTANCED_PROP(_MaxHeight);
			float4 lerpResult26 = lerp( tex2D( _Texture0, uv_Texture0 ) , tex2D( _Texture1, uv_Texture1 ) , (0.0 + (length( ( ase_vertex3Pos - float3(0,0,0) ) ) - _MinHeight_Instance) * (1.0 - 0.0) / (_MaxHeight_Instance - _MinHeight_Instance)));
			o.Albedo = lerpResult26.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13201
707;271;1652;1015;1664.283;-250.9025;1.3;True;True
Node;AmplifyShaderEditor.PosVertexDataNode;4;-1550.112,389.935;Float;False;0;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.Vector3Node;6;-1430.457,766.2792;Float;False;Constant;_Center;Center;0;0;0,0,0;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleSubtractOpNode;7;-1139.457,637.279;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.TexturePropertyNode;24;-1458.429,-240.5461;Float;True;Property;_Texture0;Texture 0;4;0;Assets/AmplifyShaderEditor/Examples/Assets/Textures/Grass/terrain_grass_01_a.jpg;False;white;Auto;0;1;SAMPLER2D
Node;AmplifyShaderEditor.TexturePropertyNode;25;-1471.12,13.27299;Float;True;Property;_Texture1;Texture 1;5;0;Assets/AmplifyShaderEditor/Examples/Assets/Textures/Misc/SimpleFoam.png;False;white;Auto;0;1;SAMPLER2D
Node;AmplifyShaderEditor.RangedFloatNode;19;-990.1875,833.2794;Float;False;InstancedProperty;_MaxHeight;Max Height;1;0;60;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.LengthOpNode;9;-940.4572,636.279;Float;False;1;0;FLOAT3;0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;18;-1015.457,750.2792;Float;False;InstancedProperty;_MinHeight;Min Height;0;0;39;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;23;-1111.965,201.0985;Float;True;Property;_Tex2IN;Tex2IN;5;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.TFHCRemap;11;-722.4572,637.279;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;0.0;False;4;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;21;-1075.161,-165.6694;Float;True;Property;_Tex1IN;Tex1IN;3;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;26;-152.6405,120.5625;Float;False;3;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;269.6666,100.3664;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;ASETemplateShaders/DefaultUnlit;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;4;0
WireConnection;7;1;6;0
WireConnection;9;0;7;0
WireConnection;23;0;25;0
WireConnection;11;0;9;0
WireConnection;11;1;18;0
WireConnection;11;2;19;0
WireConnection;21;0;24;0
WireConnection;26;0;21;0
WireConnection;26;1;23;0
WireConnection;26;2;11;0
WireConnection;2;0;26;0
ASEEND*/
//CHKSM=0EFDB2B586BB06EDB44333369D34C6E58FA4432C