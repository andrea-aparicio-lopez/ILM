Shader "Unlit/04Textura"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "" {}

    }
    SubShader
    {
        Tags { 
            "RenderType"="Opaque"  
        }

        Pass
        {

            HLSLPROGRAM
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            CBUFFER_START(UnityPerMaterial)
            sampler2D _MainTex;
            CBUFFER_END       
           
            #pragma vertex vsMain
            #pragma fragment psMain  

            struct VsIn
            {
                float4 vertex : POSITION;
                float2 uv0: TEXCOORD0;
            };

            struct VsOut
            {
                float4 pos : SV_POSITION;
                float2 outUV: TEXCOORD0;
            };

            VsOut vsMain (VsIn v)
            {
                VsOut o;
                o.pos = TransformObjectToHClip(v.vertex.xyz);
                o.outUV = v.uv0;
                return o;
            }


            float4 psMain ( VsOut i) : SV_TARGET {

                return tex2D(_MainTex, i.outUV);
            }
            ENDHLSL
        }
    }
}
