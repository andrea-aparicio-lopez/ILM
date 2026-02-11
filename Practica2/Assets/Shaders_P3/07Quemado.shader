Shader "Unlit/07Quemado"
{
        Properties
    {
        _MainTex ("Texture", 2D) = "" {}
        _CutThreshold("Cutoff threshold", float) = 0.0
        _CutHeight("Cutoff height", Range(0.0, 1.0)) = 0.3
        _NoiseScale("Noise Scale", float) = 20
        _CutWidth("Cut width", Range(0.0, 1)) = 0.1
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        { 
            Tags { "LightMode" = "UniversalForward" }
            Cull Off

            HLSLPROGRAM
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
              
            CBUFFER_START(UnityPerMaterial)
            sampler2D _MainTex;
            float _CutThreshold;
            float _CutHeight;
            float _NoiseScale;
            float _CutWidth;
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
                float4 localPos : TEXCOORD1;
            };

            VsOut vsMain (VsIn v)
            {
                VsOut o;
                o.pos = TransformObjectToHClip(v.vertex.xyz);
                o.uv0 = v.uv;
                o.localPos = v.vertex;
                return o;
            }


            float4 psMain ( VsOut i) : SV_TARGET {
                float noise;
                Unity_GradientNoise_Deterministic_float(i.uv0, _NoiseScale, noise);
                noise = noise * 2 - 1; // normalizar entre -1 y 1
                noise *= _CutHeight;
                i.localPos.y += noise;
                if(i.localPos.y >= _CutThreshold) 
                    discard;
                
                float yellowFactor = 0.0;
                if(_CutThreshold - i.localPos.y < _CutWidth)
                    yellowFactor = 1.0 + (i.localPos.y - _CutThreshold) / _CutWidth;

                return tex2D(_MainTex, i.uv0) * (1.0-yellowFactor) + float4(1.0,1.0,0.0, 1.0) * yellowFactor;
            }
            ENDHLSL
        }


        
    }
}
