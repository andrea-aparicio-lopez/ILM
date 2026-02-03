Shader "Unlit/01SVPosition"
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
            };

            VsOut vsMain (VsIn v)
            {
                VsOut o;
                o.pos = TransformObjectToHClip(v.vertex.xyz);
                return o;
            }


            float4 psMain ( VsOut i) : SV_TARGET {
                return float4(abs(i.pos.xy / i.pos.w), 0.0f, 1.0f);
            }
            ENDHLSL
        }
    }
}
