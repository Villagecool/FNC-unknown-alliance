
#pragma header
uniform vec2 iResolution;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main
vec2 uv = openfl_TextureCoordv.xy;
    vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;

uniform float distort;
uniform float rOffset;
uniform float gOffset;
uniform float bOffset;

#define texture flixel_texture2D
float _round(float n) {
    return floor(n + .5);
}

vec2 _round(vec2 n) {
    return floor(n + .5);
}

vec2 pincushionDistortion(in vec2 uv, float strength) {
	vec2 st = uv - 0.5;
    float uvA = atan(st.x, st.y);
    float uvD = dot(st, st);
    return 0.5 + vec2(sin(uvA), cos(uvA)) * sqrt(uvD) * (1.0 - strength * uvD);
}

void main() {
   
   
   vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
    // time = mod(time, 1.);
    float alpha = openfl_Alphav;
    vec2 p = pincushionDistortion(openfl_TextureCoordv, distort).xy;
    
    vec3 color = texture2D(bitmap, p).rgb;

    vec4 col1=texture2D(bitmap,openfl_TextureCoordv.st-vec2(rOffset,0.));
    vec4 col2=texture2D(bitmap,openfl_TextureCoordv.st-vec2(gOffset,0.));
    vec4 col3=texture2D(bitmap,openfl_TextureCoordv.st-vec2(bOffset,0.));
    vec4 toUse=texture2D(bitmap,openfl_TextureCoordv);
    toUse.r=col1.r;
    toUse.g=col2.g;
    toUse.b=col3.b;

    gl_FragColor = vec4(color, flixel_texture2D(bitmap, uv).w);
    
}

