// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:1,cusa:True,bamd:0,cgin:,lico:1,lgpr:1,limd:3,spmd:0,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:True,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:True,tesm:0,olmd:1,culm:0,bsrc:0,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:True,fgod:False,fgor:False,fgmd:0,fgcr:0.7426471,fgcg:0.1146735,fgcb:0.1146735,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:True,atwp:True,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:1873,x:34162,y:32717,varname:node_1873,prsc:2|normal-1521-OUT,emission-2342-OUT;n:type:ShaderForge.SFN_Tex2d,id:834,x:32912,y:33221,ptovrint:False,ptlb:texture,ptin:_texture,varname:node_834,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:b66bceaf0cc0ace4e9bdc92f14bba709,ntxv:2,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:502,x:32705,y:32322,ptovrint:False,ptlb:normal,ptin:_normal,varname:node_502,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:bbab0a6f7bae9cf42bf057d8ee2755f6,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2d,id:1302,x:32357,y:32609,ptovrint:False,ptlb:normal2,ptin:_normal2,varname:node_1302,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:cb6c5165ed180c543be39ed70e72abc8,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Lerp,id:1521,x:33520,y:32535,varname:node_1521,prsc:2|A-502-RGB,B-387-OUT,T-4334-OUT;n:type:ShaderForge.SFN_Lerp,id:2342,x:33528,y:33379,varname:node_2342,prsc:2|A-834-RGB,B-1446-RGB,T-1336-OUT;n:type:ShaderForge.SFN_Tex2d,id:4996,x:32909,y:33532,ptovrint:False,ptlb:mask,ptin:_mask,varname:node_4996,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:28c7aad1372ff114b90d330f8a2dd938,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:6311,x:32682,y:33776,ptovrint:False,ptlb:alphaMask,ptin:_alphaMask,varname:node_6311,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:50,max:50;n:type:ShaderForge.SFN_Multiply,id:1336,x:33220,y:33502,varname:node_1336,prsc:2|A-4996-RGB,B-6311-OUT;n:type:ShaderForge.SFN_Tex2d,id:1446,x:32734,y:33410,ptovrint:False,ptlb:tex2,ptin:_tex2,varname:node_1446,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:66321cc856b03e245ac41ed8a53e0ecc,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:387,x:33119,y:32559,varname:node_387,prsc:2|A-1302-RGB,B-5879-OUT;n:type:ShaderForge.SFN_Slider,id:5879,x:32689,y:32695,ptovrint:False,ptlb:normalSlider,ptin:_normalSlider,varname:node_5879,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:50,max:50;n:type:ShaderForge.SFN_Lerp,id:4334,x:32814,y:32927,varname:node_4334,prsc:2|A-1302-R,B-1302-G,T-1302-B;proporder:834-502-1302-4996-6311-1446-5879;pass:END;sub:END;*/

Shader "Barrel/maskShader" {
    Properties {
        _texture ("texture", 2D) = "black" {}
        _normal ("normal", 2D) = "bump" {}
        _normal2 ("normal2", 2D) = "bump" {}
        _mask ("mask", 2D) = "white" {}
        _alphaMask ("alphaMask", Range(0, 50)) = 50
        _tex2 ("tex2", 2D) = "white" {}
        _normalSlider ("normalSlider", Range(0, 50)) = 50
        [MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
        _Stencil ("Stencil ID", Float) = 0
        _StencilReadMask ("Stencil Read Mask", Float) = 255
        _StencilWriteMask ("Stencil Write Mask", Float) = 255
        _StencilComp ("Stencil Comparison", Float) = 8
        _StencilOp ("Stencil Operation", Float) = 0
        _StencilOpFail ("Stencil Fail Operation", Float) = 0
        _StencilOpZFail ("Stencil Z-Fail Operation", Float) = 0
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
            "CanUseSpriteAtlas"="True"
            "PreviewType"="Plane"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend One OneMinusSrcAlpha
            ZWrite Off
            
            Stencil {
                Ref [_Stencil]
                ReadMask [_StencilReadMask]
                WriteMask [_StencilWriteMask]
                Comp [_StencilComp]
                Pass [_StencilOp]
                Fail [_StencilOpFail]
                ZFail [_StencilOpZFail]
            }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #pragma multi_compile _ PIXELSNAP_ON
            #include "UnityCG.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase
            #pragma only_renderers d3d9 d3d11 glcore gles3 
            #pragma target 3.0
            uniform sampler2D _texture; uniform float4 _texture_ST;
            uniform sampler2D _normal; uniform float4 _normal_ST;
            uniform sampler2D _normal2; uniform float4 _normal2_ST;
            uniform sampler2D _mask; uniform float4 _mask_ST;
            uniform float _alphaMask;
            uniform sampler2D _tex2; uniform float4 _tex2_ST;
            uniform float _normalSlider;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                #ifdef PIXELSNAP_ON
                    o.pos = UnityPixelSnap(o.pos);
                #endif
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _normal_var = UnpackNormal(tex2D(_normal,TRANSFORM_TEX(i.uv0, _normal)));
                float3 _normal2_var = UnpackNormal(tex2D(_normal2,TRANSFORM_TEX(i.uv0, _normal2)));
                float3 normalLocal = lerp(_normal_var.rgb,(_normal2_var.rgb*_normalSlider),lerp(_normal2_var.r,_normal2_var.g,_normal2_var.b));
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
////// Lighting:
////// Emissive:
                float4 _texture_var = tex2D(_texture,TRANSFORM_TEX(i.uv0, _texture));
                float4 _tex2_var = tex2D(_tex2,TRANSFORM_TEX(i.uv0, _tex2));
                float4 _mask_var = tex2D(_mask,TRANSFORM_TEX(i.uv0, _mask));
                float3 emissive = lerp(_texture_var.rgb,_tex2_var.rgb,(_mask_var.rgb*_alphaMask));
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
