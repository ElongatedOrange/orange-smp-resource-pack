#version 330
#extension GL_ARB_separate_shader_objects : require

#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
#include <minecraft:fog.glsl>
#endif

#include <minecraft:dynamictransforms.glsl>
#include <minecraft:globals.glsl>
#include <minecraft:oit.glsl>

uniform sampler2D Sampler0;

#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
layout(location = 0) in float sphericalVertexDistance;
layout(location = 1) in float cylindricalVertexDistance;
#endif

layout(location = 2) in vec4 vertexColor;
layout(location = 3) in vec2 texCoord0;

#ifndef OIT_ALPHA_ONLY
layout(location = 0) out vec4 fragColor;
#endif


layout(location = 4) in vec2 hudUV;
layout(location = 5) flat in ivec4 hudInfo;
layout(location = 6) flat in vec4 hudBounds;
layout(location = 7) flat in vec2 hudSize;
#ifdef IS_GUI
vec4 kitchenHudColor() {
    float size=float(hudInfo.z);
    if(hudInfo.x==1) {
        vec2 cell=(vec2(4.0)+hudUV*8.0)/size;
        return texture(Sampler0,hudBounds.xy+cell*hudBounds.zw);
    }
    if(hudInfo.x==0) {
        vec2 pixel=clamp(hudUV*size,vec2(.5),vec2(size-.5));
        // Transport bytes occupy only each corner's 3x2 pixels.
        if(min(pixel.x,size-pixel.x)<4.0 && min(pixel.y,size-pixel.y)<4.0) {
            if(hudSize.x<900.0) return vec4(0.0);
            pixel=vec2(4.5);
        }
        return texture(Sampler0,hudBounds.xy+pixel/size*hudBounds.zw);
    }
    vec4 fill=texture(Sampler0,hudBounds.xy+hudBounds.zw*.5);
    int style=hudInfo.y;
    if(style==6) return fill;
    if(style==7 || style==9 || style==11) {
        float radius=length((hudUV-.5)*2.0);
        float alpha=1.0-smoothstep(.86,.97,radius);
        float ring=smoothstep(.64,.76,radius);
        float pulse=style==7?.78+.22*sin(GameTime*5200.0):1.0;
        return vec4(fill.rgb*mix(.42,1.0,ring)*pulse,alpha*(style==11?.48:1.0));
    }
    float rounding=min(4.0,min(hudSize.x,hudSize.y)*.25);
    vec2 q=abs((hudUV-.5)*hudSize)-(hudSize*.5-rounding);
    float distance=length(max(q,0.0))+min(max(q.x,q.y),0.0)-rounding;
    float edge=smoothstep(-2.0,-.7,distance);
    fill.rgb=mix(fill.rgb,fill.rgb*1.22+vec3(.06,.035,.01),edge);
    fill.a*=1.0-smoothstep(-.5,.5,distance);
    return fill;
}
#endif

vec4 calculateFinalColor(vec4 color) {
    #ifdef OIT_ACCUMULATE
    color = sampleColorForAccumulation(color);
    #endif

    #if !defined(IS_SEE_THROUGH) && !defined(IS_GUI)

    #ifdef OIT_ACCUMULATE
    vec4 fogColor = vec4(FogColor.rgb * color.a, FogColor.a);
    #else
    vec4 fogColor = FogColor;
    #endif

    color = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, fogColor);
    #endif

    return color;
}

void main() {
    #ifdef IS_GRAYSCALE
    vec4 texColor = texture(Sampler0, texCoord0).rrrr;
    #else
    vec4 texColor = texture(Sampler0, texCoord0);
    #endif

    vec4 color = texColor * vertexColor * ColorModulator;

    // Orange SMP cookbook glyphs alone use the reserved RGB marker FE FD FC.
    // Preserve vanilla text, world text, fog and OIT code paths byte for byte.
    #ifdef IS_GUI
    if (all(lessThan(abs(vertexColor.rgb - vec3(254.0, 253.0, 252.0) / 255.0), vec3(0.001)))) {
        color = texColor * ColorModulator;
        float warmth = 0.012 * (0.5 + 0.5 * sin(GameTime * 1200.0));
        color.rgb += vec3(warmth, warmth * 0.55, 0.0) * texColor.a;
    }
    #endif


    #ifdef IS_GUI
    if(hudInfo.x>=0) color=kitchenHudColor();
    #endif
    if (color.a < (hudInfo.x>=0 ? .01 : .1)) {
        discard;
    }

    #ifdef OIT_ALPHA_ONLY
    executeAlphaOnlyPhase(gl_FragCoord.z, color.a);
    #else
    fragColor = calculateFinalColor(color);
    #endif
}
