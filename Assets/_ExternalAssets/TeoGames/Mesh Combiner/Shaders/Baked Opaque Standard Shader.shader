Shader "Custom/Baked Opaque Standard Shader"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _EmissionTex ("Emission (RGB)", 2D) = "white" {}
        _SmoothnessTex ("Smoothness (R)", 2D) = "white" {}
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _EmissionTex;
        sampler2D _SmoothnessTex;
        half _Metallic;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            fixed4 g = tex2D(_SmoothnessTex, IN.uv_MainTex);
            fixed4 e = tex2D(_EmissionTex, IN.uv_MainTex);

            o.Albedo = c.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = g.r;
            o.Emission.rgb = e.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}