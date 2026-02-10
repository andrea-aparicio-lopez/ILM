Shader "Unlit/05Ruido"
{
        Properties
    {
        _NoiseScale("Noise Scale", float) = 20
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
            float _NoiseScale;
            CBUFFER_END  

            #pragma vertex vsMain
            #pragma fragment psMain  

            float2 Unity_GradientNoise_Deterministic_Dir_float(float2 p)
            {
                p = p% 289;
                float x = (34 * p.x +1) * p.x % 289 + p.y;
                x = (34 * x + 1) * x % 289;
                x = frac(x/41) * 2 - 1;
                return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
            }

            void Unity_GradientNoise_Deterministic_float (float2 UV, float Scale, out float Out)
            {
                float2 p = UV * Scale;
                float2 ip = floor(p);
                float2 fp = frac(p);
                float d00 = dot(Unity_GradientNoise_Deterministic_Dir_float(ip), fp);
                float d01 = dot(Unity_GradientNoise_Deterministic_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
                float d10 = dot(Unity_GradientNoise_Deterministic_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
                float d11 = dot(Unity_GradientNoise_Deterministic_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
                fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
                Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
            }


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
                float grey;
                Unity_GradientNoise_Deterministic_float(i.uv0, _NoiseScale, grey);
                return float4(grey, grey, grey, 1.0);
            }
            ENDHLSL
        }

    }
}
