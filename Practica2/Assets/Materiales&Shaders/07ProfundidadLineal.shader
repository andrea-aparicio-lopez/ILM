Shader "Unlit/07ProfundidadLineal"
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
                o.depthPos =  o.pos;
                return o;
            }


            float4 psMain ( VsOut i) : SV_TARGET {
                float depthZ = Linear01DepthFromNear(i.depthPos.z / i.depthPos.w, _ZBufferParams);
                int d = (int)(depthZ * 10);
                depthZ = (float)d / 10;

                return float4(depthZ, depthZ, depthZ, 1.0f);


            }
            ENDHLSL
        }
    }
}