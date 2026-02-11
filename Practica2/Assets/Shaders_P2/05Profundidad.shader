Shader "Unlit/05Profundidad"
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
                float4 depthPos : TEXCOORD0;
            };

            VsOut vsMain (VsIn v)
            {
                VsOut o;
                o.pos = TransformObjectToHClip(v.vertex.xyz);
                o.depthPos =  ComputeScreenPos(o.pos);
                return o;
            }


            float4 psMain ( VsOut i) : SV_TARGET {
                float depthZ = i.depthPos.z / i.depthPos.w;
                return float4(depthZ, depthZ, depthZ, 1.0f);


            }
            ENDHLSL
        }
    }
}
