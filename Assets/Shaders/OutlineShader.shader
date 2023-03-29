Shader "Custom/OutlineShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        
        _OutlineColor("Outline Color", Color) = (0,0,0,1)
        _OutlineWidth("Outline Width", Range(0.002, 0.2)) = 0.01
    }
    SubShader
    {
        Tags { "Geometry" = "Transparent" }
        //LOD 200

        ZWrite off
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert vertex:vert
        

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        float _OutlineWidth;
        fixed4 _Color;
        fixed4 _OutlineColor;

        void vert(inout appdata_full v)
        {
            v.vertex.xyz += v.normal * _OutlineWidth;
        }

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf(Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            o.Emission = _OutlineColor.rgb;
        }
        ENDCG
        ZWrite on


        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;

        UNITY_INSTANCING_BUFFER_START(Props)
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {

            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
 
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
