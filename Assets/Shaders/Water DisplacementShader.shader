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

        _speed("Zoom",Range(-10,10)) = 1

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

            half _speed;


            struct Input
            {
                float2 uv_MainTex;
            };

            float4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten) {

                float diff = dot(s.Normal, lightDir);
                float h = diff * 0.5 + 0.5;
                float2 rh = h;
                float3 ramp = tex2D(_RampTex, rh).rgb;

                float4 c;
                c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
                c.a = s.Alpha;
                return c;
            }

            


            v2f vert(inout appdata_full v) {
                v2f o;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                float3 displaceCalc = v.vertex.xyz;
                displaceCalc.y = _Amp * sin(displaceCalc.x * _v + _m *(_speed * _Time.y)) * _z ;
                v.vertex.xyz = displaceCalc; 
                float displacement = tex2Dlod(_DisplacementMap, float4(o.uv, 0, 0)).r;
                //float displacement = 0;

                float4 temp = float4(v.vertex.x, v.vertex.y, v.vertex.z, 1.0);
                temp.xyz += displacement * v.normal * _DisplacementStrength;
                if(temp.y > 0){
                    temp.y = 1 *_z;
                }
                else{
                    temp.y = -1 *_z;
                }
                o.vertex = UnityObjectToClipPos(temp);
   
                //UNITY_TRANSFER_FOG(o, o.vertex);
                return o;
            }

            void surf (Input IN, SurfaceOutput o) {
                fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;



                o.Albedo = c.rgb;
		    }

            ENDCG

        }

    }
}
