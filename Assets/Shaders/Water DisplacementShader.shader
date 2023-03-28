Shader "Custom/WaterDisplace"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}

        _RampTex("Toon Ramp Texture", 2D) = "white" {}
        _Contribution("Contribution", Range(0, 1)) = 0.5

        _DisplacementMap("Displacement", 2D) = "black" {}
        _DisplacementStrength("Displacement Strength", Range(0,5)) = 0.5

        _v("Smoothness", Range(-10,10)) = 1.0
        _m("Movement", Range(-10,10)) = 1.0
        _z("Height", Range(-10,10)) = 1.0
        _Amp("Ampliture", Range(0,20)) = 5.0

    }
    SubShader
    {
        Pass
        {

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog
            #include "UnityCG.cginc"
            // Physically based Standard lighting model, and enable shadows on all light types
            //#pragma surface surf Standard fullforwardshadows

            fixed4 _Color;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _DisplacementMap;
            half _DisplacementStrength;

            half _v;
            half _m;
            half _z;
            half _Amp;


            struct Input
            {
                float2 uv_MainTex;
            };

            struct appdata {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float normal : NORMAL;
            };

            struct v2f
            {
                float2 uv :TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
            // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
            // #pragma instancing_options assumeuniformscaling
            UNITY_INSTANCING_BUFFER_START(Props)
                // put more per-instance properties here
            UNITY_INSTANCING_BUFFER_END(Props)


            v2f vert(appdata v) {
                v2f o;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                float3 displaceCalc = v.vertex.xyz;
                displaceCalc.y = _Amp * sin(displaceCalc.x * _v + _m) * _z ;
                v.vertex.xyz = displaceCalc; 
                float displacement = tex2Dlod(_DisplacementMap, float4(o.uv, 0, 0)).r;
                //float displacement = 0;

                float4 temp = float4(v.vertex.x, v.vertex.y, v.vertex.z, 1.0);
                temp.xyz += displacement * v.normal * _DisplacementStrength;
                if(temp.y > 0){
                    temp.y = 1;
                }
                else{
                    temp.y = -1;
                }
                o.vertex = UnityObjectToClipPos(temp);
   
                //UNITY_TRANSFER_FOG(o, o.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target{
                fixed4 col = tex2D(_MainTex, i.uv)* _Color;
                UNITY_APPLY_FOG(i.fogCoord, col)
                return col;

            }
            ENDCG

        }

        Pass
        {
            Tags {"LightMode" = "ShadowCaster"}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_shadowcaster
            #include "UnityCG.cginc"
            struct appdata {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };
            struct v2f {
                V2F_SHADOW_CASTER;
            };
                v2f vert(appdata v)
            {
                    v2f o;
                    TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
                    return o;
            }
                float4 frag(v2f i) : SV_Target
            {
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }

    }
}
