Shader "Unlit/08Barras"
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
                float4 screenPos : TEXCOORD0;
            };

            VsOut vsMain (VsIn v)
            {
                VsOut o;
                o.pos = TransformObjectToHClip(v.vertex.xyz); 
                o.screenPos = ComputeScreenPos(o.pos);
                return o;
            }


            float4 psMain ( VsOut i) : SV_TARGET {
                int screenPixelPos = (int)(i.screenPos.x / i.screenPos.w * _ScreenParams.x);
                if(screenPixelPos % 4){
                    return float4(0.0f, 0.0f, 0.0f, 1.0f);
                }
                else{
                    return float4(1.0f, 1.0f, 0.0f, 1.0f);
                }
                


            }
            ENDHLSL
        }
    }
}