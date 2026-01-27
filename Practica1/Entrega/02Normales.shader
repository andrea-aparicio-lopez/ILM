Shader "Unlit/02Normales"
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
                float3 normal : NORMAL;
            };

            struct VsOut
            {
                float4 pos : SV_POSITION;
                float4 colorNormal : COLOR;
            };

            VsOut vsMain (VsIn v)
            {
                VsOut o;
                o.pos = TransformObjectToHClip(v.vertex.xyz);
                o.colorNormal = abs(float4(v.normal, 1.0));
                return o;
            }


            float4 psMain ( VsOut i) : SV_TARGET {
                return i.colorNormal;
            }
            ENDHLSL
        }
    }
}
