Shader "Unlit/04ScreenSpaceNoDivW"
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
                float3 screenPosNoW: TEXCOORD0;
            };

            VsOut vsMain (VsIn v)
            {
                VsOut o;
                o.pos = TransformObjectToHClip(v.vertex.xyz);
                o.screenPosNoW = ComputeScreenPos(o.pos) / o.pos.w;
                return o;
            }


            float4 psMain ( VsOut i) : SV_TARGET {
                return float4(i.screenPosNoW.xy, 0.0f, 1.0f);


            }
            ENDHLSL
        }
    }
}
