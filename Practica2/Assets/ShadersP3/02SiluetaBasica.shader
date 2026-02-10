Shader "Unlit/02SiluetaBasica"
{
    SubShader
    {
        Tags { "RenderType"="Opaque"}

        Pass {
            Name "PasadaSilueta"
            Tags { "LightMode" = "UniversalForward" }

            Cull Front
            
            HLSLPROGRAM
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
           
            #pragma vertex vsMain
            #pragma fragment psMain  

            struct VsIn
            {
                float4 vertex : POSITION;
            };

            struct VsOut
            {
                float4 pos : SV_POSITION;
            };

            VsOut vsMain (VsIn v)
            {
                VsOut o;
                o.pos = TransformObjectToHClip(v.vertex.xyz * 1.05);
                return o;
            }


            float4 psMain ( VsOut i) : SV_TARGET {
                return float4(0.0, 0.0,0.0 ,1.0);
            }
            ENDHLSL
        }



        Pass { 
            Name "PasadaRojo"

            HLSLPROGRAM
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
           
            #pragma vertex vsMain
            #pragma fragment psMain  

            struct VsIn
            {
                float4 vertex : POSITION;
            };

            struct VsOut
            {
                float4 pos : SV_POSITION;
            };

            VsOut vsMain (VsIn v)
            {
                VsOut o;
                o.pos = TransformObjectToHClip(v.vertex.xyz);
                return o;
            }


            float4 psMain ( VsOut i) : SV_TARGET {
                return float4(1.0, 0.0,0.0 ,1.0);
            }
            ENDHLSL
        }
        


    }
}
