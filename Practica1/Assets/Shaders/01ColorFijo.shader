Shader "Unlit/01ColorFijo"
{
    Properties
    {
        _Color ("Color" , Color ) = (0.0 , 1.0 , 0.0, 1.0)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            HLSLPROGRAM
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            CBUFFER_START(UnityPerMaterial)
            float4 _Color ;
            CBUFFER_END
           
            #pragma vertex vsMain
            #pragma fragment psMain  

            struct VsIn
            {
                float4 vertex : POSITION;
            };

            struct VsOut
            {
                float4 pos : SV_POSITION;
            };

            VsOut vsMain (VsIn v)
            {
                VsOut o;
                o.pos = TransformObjectToHClip(v.vertex.xyz);
                return o;
            }


            float4 psMain ( VsOut i) : SV_TARGET {
                return _Color ;
            }
            ENDHLSL
        }
    }
}
