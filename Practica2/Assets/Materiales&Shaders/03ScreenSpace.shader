Shader "Unlit/03ScreenSpace"
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
                //float4 pos2: TEXCOORD0;
                float4 screenPos: TEXCOORD0;
            };

            VsOut vsMain (VsIn v)
            {
                VsOut o;
                o.pos = TransformObjectToHClip(v.vertex.xyz);
                o.screenPos = ComputeScreenPos(o.pos);
                return o;
            }


            float4 psMain ( VsOut i) : SV_TARGET {
                //float4 screenPos = ComputeScreenPos(i.pos2);
                //return float4(screenPos.xy / screenPos.w, 0.0f, 1.0f);
                return float4(i.screenPos.xy / i.screenPos.w, 0.0f, 1.0f);


            }
            ENDHLSL
        }
    }
}
