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
    if(hudInfo.x==0 || hudInfo.x==3) {
        vec2 uv=hudUV;
        if(hudInfo.x==3){
            float t=GameTime*1200.0,angle=0.0;vec2 offset=vec2(0.0);float stretch=1.0;int tool=hudInfo.y;
            if(tool==1){angle=sin(t*9.0)*.13;offset.y=abs(sin(t*9.0))*.045;}
            else if(tool==2){angle=sin(t*4.0)*.18;offset=vec2(cos(t*4.0),sin(t*4.0))*.035;}
            else if(tool==3 || tool==11){angle=sin(t*3.0)*.22;offset.y=abs(sin(t*3.0))*.065;}
            else if(tool==14){offset=vec2(sin(t*43.0),cos(t*37.0))*.018;}
            else if(tool==7){stretch=1.0+sin(t*3.0)*.06;}
            else if(tool==6 || tool==5){offset.x=sin(t*3.0)*.045;angle=sin(t*3.0)*.06;}
            else if(tool==10 || tool==15){angle=sin(t*2.5)*.10;}
            else{offset.y=sin(t*2.0)*.02;}
            float c=cos(angle),s=sin(angle);uv=mat2(c,-s,s,c)*(uv-.5-offset);uv.x/=stretch;uv+=.5;
            if(any(lessThan(uv,vec2(0.0)))||any(greaterThan(uv,vec2(1.0))))return vec4(0.0);
        }
        vec2 pixel=clamp(uv*size,vec2(.5),vec2(size-.5));
        // Transport bytes occupy only each corner's 3x2 pixels.
        if(min(pixel.x,size-pixel.x)<4.0 && min(pixel.y,size-pixel.y)<4.0) {
            if(hudSize.x<900.0) return vec4(0.0);
            pixel=vec2(4.5);
        }
        return texture(Sampler0,hudBounds.xy+pixel/size*hudBounds.zw);
    }
    vec4 fill=texture(Sampler0,hudBounds.xy+hudBounds.zw*.5);
    int style=hudInfo.y;
    if(style>=12){
        vec2 p=(hudUV-.5)*2.0;float radius=length(p),alpha=0.0;
        if(style==12 || style==13){float a=atan(p.x,-p.y);float sector=mod(a+3.14159265/5.0,6.2831853/5.0)-3.14159265/5.0;float boundary=.43/cos(sector);float spike=mix(.9,boundary,abs(sector)/(3.14159265/5.0));alpha=1.0-smoothstep(spike-.06,spike,radius);}
        else if(style==14){alpha=(1.0-smoothstep(.04,.14,abs(radius-.65)))*.55;alpha=max(alpha,(1.0-smoothstep(.06,.18,length(p-vec2(-.22,-.28))))*.8);}
        else if(style==15){float d=min(abs(p.x)+abs(p.y)*.27,abs(p.y)+abs(p.x)*.27);alpha=(1.0-smoothstep(.12,.22,d))*(1.0-smoothstep(.65,.9,radius));}
        else{float d=abs(abs(p.x)-abs(p.y));alpha=(1.0-smoothstep(.14,.28,d))*(1.0-smoothstep(.6,.95,radius));}
        return vec4(fill.rgb,alpha);
    }
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
