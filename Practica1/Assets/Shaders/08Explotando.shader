Shader "Unlit/08Explotando"
{
    Properties
    {
        _Color ("Color" , Color ) = (0.0 , 1.0 , 0.0, 1.0)
        _Scale("Scale", float) = 0.10
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
            float _Scale;
            CBUFFER_END

           
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
            };

            VsOut vsMain (VsIn v)
            {
                VsOut o;
                float3 normalScale = _Scale * _SinTime.w * v.normal;
                o.pos = TransformObjectToHClip(v.vertex.xyz + normalScale);
                return o;
            }


            float4 psMain ( VsOut i) : SV_TARGET {
                return _Color ;
            }
            ENDHLSL
        }
    }
}
