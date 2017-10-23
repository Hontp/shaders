// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "bump_mapping"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_MainTex("MainTex", 2D) = "white" {}
		_normal("normal", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		BlendOp Add
		CGPROGRAM
		#pragma target 4.5
		#pragma multi_compile_instancing
		#pragma exclude_renderers xbox360 xboxone ps4 psp2 n3ds wiiu 
		#pragma surface surf StandardSpecular keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _normal;
		uniform float4 _normal_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 uv_normal = i.uv_texcoord * _normal_ST.xy + _normal_ST.zw;
			float3 tex2DNode7 = UnpackNormal( tex2D( _normal, uv_normal ) );
			o.Normal = ( tex2DNode7 * tex2DNode7.b );
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode1 = tex2D( _MainTex, uv_MainTex );
			o.Albedo = ( tex2DNode1 * tex2DNode1.a ).rgb;
			float3 temp_cast_1 = (0.57).xxx;
			o.Specular = temp_cast_1;
			o.Smoothness = 0.56;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13201
240;261;1652;1015;1212.689;344.7167;1.3;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-800.8431,-199.3826;Float;True;Property;_MainTex;MainTex;0;0;Assets/Art/MAPTEST_DIFFUSE.png;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;7;-826.6886,211.6831;Float;True;Property;_normal;normal;1;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-138.2581,-199.9026;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;6;101.0471,652.9734;Float;False;Constant;_smoothness;smoothness;2;0;0.56;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;5;106.8294,479.6134;Float;False;Constant;_sepcular;sepcular;2;0;0.57;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-151.6635,260.3953;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;611.9569,213.5155;Float;False;True;5;Float;ASEMaterialInspector;0;0;StandardSpecular;bump_mapping;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;True;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;False;False;False;False;False;False;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;2;SrcAlpha;OneMinusSrcAlpha;0;Zero;Zero;Add;Add;0;False;10;1,0,0,0;VertexScale;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;1;0
WireConnection;3;1;1;4
WireConnection;4;0;7;0
WireConnection;4;1;7;3
WireConnection;0;0;3;0
WireConnection;0;1;4;0
WireConnection;0;3;5;0
WireConnection;0;4;6;0
ASEEND*/
//CHKSM=419A437CD93812DBAB38815C6697D443A49A5CDD