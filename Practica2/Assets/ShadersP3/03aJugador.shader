Shader "Unlit/03aJugador"
{
        Properties
    {
        _MainTex ("Texture", 2D) = "" {}
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        { 

            Tags { "LightMode" = "UniversalForward" }


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
                float2 uv : TEXCOORD0;
            };

            struct VsOut
            {
                float4 pos : SV_POSITION;
                float2 uv0: TEXCOORD0;
            };

            VsOut vsMain (VsIn v)
            {
                VsOut o;
                o.pos = TransformObjectToHClip(v.vertex.xyz);
                o.uv0 = v.uv;
                return o;
            }


            float4 psMain ( VsOut i) : SV_TARGET {
               return tex2D(_MainTex, i.uv0);
            }
            ENDHLSL
        }

    }
}
