Shader "Unlit/03bVisibleAtras"
{

    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue" = "Geometry+10"}

        Pass
        { 

            Tags { "LightMode" = "UniversalForward" }
            ZTest Greater
            ZWrite Off

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
               return float4(1.0, 0.0, 0.0, 1.0);
            }
            ENDHLSL
        }

    }
}
