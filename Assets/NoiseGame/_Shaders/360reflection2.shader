// original source: http://www.clicktorelease.com/code/streetViewReflectionMapping
// ported by http://unitycoder.com/blog/2012/10/06/360-panorama-reflection-shader/
Shader "Custom/360reflection2" {
Properties {
_texture ("texture (RGB)", 2D) = "white" {}
_scaledTexture ("scaledTexture (RGB)", 2D) = "white" {}
}
SubShader {
Tags { "RenderType"="Opaque" }
LOD 200
 
CGPROGRAM
#pragma target 3.0
#pragma surface surf Lambert vertex:vert
 
float3 vReflect;
float3 vRefract;
 
struct Input {
float2 uv_MainTex;
float4 pos : SV_POSITION;
float3 vReflect;
float3 vRefract;
};
 
void vert (inout appdata_full v, out Input o)
{
float4 mPosition = mul(_Object2World,float4(v.vertex.xyz, 1.0 ));
float3 nWorld = normalize( mul(  float3x3(_Object2World[0].xyz, _Object2World[1].xyz, _Object2World[2].xyz) ,v.normal ));
o.vReflect = normalize( reflect( normalize( mPosition.xyz - _WorldSpaceCameraPos ), nWorld ) );
o.vRefract = normalize( refract( normalize( mPosition.xyz - _WorldSpaceCameraPos ), nWorld, 0.9 ) );
o.pos = mul(UNITY_MATRIX_P * UNITY_MATRIX_MV,float4(v.vertex.xyz, 1.0));
}
 
uniform float rAmount;
uniform sampler2D _texture;
uniform sampler2D _scaledTexture;
 
void surf (Input IN, inout SurfaceOutput o)
{
float PI = 3.14159265358979323846264;
float yaw = .5 - atan2(IN.vReflect.z, - IN.vReflect.x ) / ( 2.0 * PI );
float pitch = .5 - asin( vReflect.y ) / PI;
float3 color = tex2D(_scaledTexture, float2( yaw, pitch ) ).rgb * ( 1.0 - rAmount );
yaw = .5 - atan2(IN.vRefract.z, - vRefract.x ) / ( 2.0 * PI );
pitch = .5 - asin(IN.vRefract.y ) / PI;
color += tex2D(_texture, float2( yaw, pitch ) ).rgb * rAmount;
half4 c =  float4( color, 1.0 );
o.Albedo = c.rgb;
o.Alpha = c.a;
}
 
ENDCG
}
FallBack "Diffuse"
}