Shader "Custom/BumpDisplace"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _DisplacementMap("Displacement", 2D) = "black" {}
        _DisplacementStrength("Displacement Strength", Range(0,5)) = 0.5
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
                
                float displacement = tex2Dlod(_DisplacementMap, float4(o.uv, 0, 0)).r;
                v.vertex.y = displacement * _DisplacementStrength;
                //float displacement = 0;
                float4 temp = float4(v.vertex.x, v.vertex.y, v.vertex.z, 1.0);
                temp.xyz += displacement * v.normal * _DisplacementStrength;
                o.vertex = UnityObjectToClipPos(temp);
   
                //UNITY_TRANSFER_FOG(o, o.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target{
                fixed4 col = tex2D(_MainTex, i.uv) * _Color;
                UNITY_APPLY_FOG(i.fogCoord, col)
                return col;
            }
            ENDCG
        }
    }
}
