Shader "Unlit/03UVs"
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
                float2 uv0: TEXCOORD0;
            };

            struct VsOut
            {
                float4 pos : SV_POSITION;
                float4 colorUV: COLOR;
            };

            VsOut vsMain (VsIn v)
            {
                VsOut o;
                o.pos = TransformObjectToHClip(v.vertex.xyz);
                o.colorUV = float4(v.uv0, 0.0, 1.0);
                return o;
            }


            float4 psMain ( VsOut i) : SV_TARGET {
                return i.colorUV;
            }
            ENDHLSL
        }
    }
}
