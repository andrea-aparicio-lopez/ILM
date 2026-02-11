Shader "Unlit/02ClipSpace"
{
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        { 
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
                float4 pos2: TEXCOORD0;
            };

            VsOut vsMain (VsIn v)
            {
                VsOut o;
                o.pos = o.pos2 = TransformObjectToHClip(v.vertex.xyz);
                return o;
            }


            float4 psMain ( VsOut i) : SV_TARGET {
                return float4(abs(i.pos2.xy / i.pos2.w), 0.0f, 1.0f);
            }
            ENDHLSL
        }
    }
}
