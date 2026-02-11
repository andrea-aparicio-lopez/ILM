Shader "Unlit/04AlphaClipping"
{
        Properties
    {
        _MainTex ("Texture", 2D) = "" {}
        _CutThresold("Cutoff thresold", float) = 0.0
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
            float _CutThresold;
            CBUFFER_END  

            #pragma vertex vsMain
            #pragma fragment psMain  

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
                if(i.localPos.y > _CutThresold) 
                    discard;
               return tex2D(_MainTex, i.uv0);
            }
            ENDHLSL
        }

    }
}
