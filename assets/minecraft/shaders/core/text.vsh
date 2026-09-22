#version 330
#extension GL_ARB_separate_shader_objects : require

#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
#include <minecraft:fog.glsl>
#include <minecraft:sample_lightmap.glsl>
#endif

#include <minecraft:dynamictransforms.glsl>
#include <minecraft:projection.glsl>
#include <minecraft:globals.glsl>

layout(location = 0) in vec3 Position;
layout(location = 1) in vec4 Color;
layout(location = 2) in vec2 UV0;
#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
layout(location = 3) in ivec2 UV2;
#endif

#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
uniform sampler2D Sampler2;
layout(location = 0) out float sphericalVertexDistance;
layout(location = 1) out float cylindricalVertexDistance;
#endif

layout(location = 2) out vec4 vertexColor;
layout(location = 3) out vec2 texCoord0;

uniform sampler2D Sampler0;

layout(location = 4) out vec2 hudUV;
layout(location = 5) flat out ivec4 hudInfo;
layout(location = 6) flat out vec4 hudBounds;
layout(location = 7) flat out vec2 hudSize;
#ifdef IS_GUI
ivec3 kitchenPixel(ivec2 pixel, ivec2 atlas) {
    if (any(lessThan(pixel, ivec2(0))) || any(greaterThanEqual(pixel, atlas))) return ivec3(-1);
    return ivec3(round(texelFetch(Sampler0, pixel, 0).rgb * 255.0));
}
void kitchenTransport() {
    ivec2 atlas = textureSize(Sampler0, 0);
    ivec2 pixel = clamp(ivec2(UV0 * vec2(atlas)), ivec2(0), atlas - 1);
    const ivec3 marker = ivec3(19,112,71), second = ivec3(242,137,45);
    if (any(notEqual(kitchenPixel(pixel, atlas), marker))) return;
    // Mirrored corner headers, never gl_VertexID: GUI base vertices are unaligned.
    for (int dx=-1; dx<=1; dx+=2) {
        if (any(notEqual(kitchenPixel(pixel+ivec2(dx,0),atlas),second))) continue;
        ivec3 w = kitchenPixel(pixel+ivec2(dx*2,0),atlas);
        if (w.z<0 || w.z>3) continue;
        for (int dy=-1; dy<=1; dy+=2) {
            ivec3 h=kitchenPixel(pixel+ivec2(0,dy),atlas), cell=kitchenPixel(pixel+ivec2(dx,dy),atlas);
            int size=cell.x*256+cell.y;
            if(size<8 || size>256 || (size&(size-1))!=0 || cell.z!=0 || h.z<0 || h.z>16) continue;
            ivec2 oppositeX=pixel+ivec2(dx*(size-1),0),oppositeY=pixel+ivec2(0,dy*(size-1));
            if(any(notEqual(kitchenPixel(oppositeX,atlas),marker)) || any(notEqual(kitchenPixel(oppositeY,atlas),marker))) continue;
            if(any(notEqual(kitchenPixel(oppositeX-ivec2(dx,0),atlas),second)) || any(notEqual(kitchenPixel(oppositeY+ivec2(dx,0),atlas),second))) continue;
            vec2 dimensions=vec2(w.x*256+w.y,h.x*256+h.y)*.25;
            if(any(lessThanEqual(dimensions,vec2(0)))) continue;
            vec2 corner=vec2(dx<0?1.0:0.0,dy<0?1.0:0.0);
            ivec3 encoded=ivec3(round(Color.rgb*255.0));
            vec2 origin=vec2(encoded.x*16+(encoded.y>>4),(encoded.y&15)*256+encoded.z)-1024.0;
            vec2 canvas=origin+corner*dimensions;
            float scale=min(ScreenSize.x/960.0,ScreenSize.y/540.0);
            vec2 screen=(ScreenSize-vec2(960,540)*scale)*.5+canvas*scale;
            gl_Position=vec4(screen.x/ScreenSize.x*2.0-1.0,1.0-screen.y/ScreenSize.y*2.0,0.0,1.0);
            hudUV=corner;hudInfo=ivec4(w.z,h.z,size,0);hudSize=dimensions;
            vec2 base=vec2(pixel)-corner*float(size-1);
            hudBounds=vec4(base/vec2(atlas),vec2(size)/vec2(atlas));
            vertexColor=vec4(1.0);return;
        }
    }
}
#endif

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
    sphericalVertexDistance = fog_spherical_distance(Position);
    cylindricalVertexDistance = fog_cylindrical_distance(Position);
    vertexColor = Color * sample_lightmap(Sampler2, UV2);
#else
    vertexColor = Color;
#endif
    texCoord0 = UV0;

    hudUV=vec2(0);hudInfo=ivec4(-1,0,0,0);hudBounds=vec4(0);hudSize=vec2(0);
#ifdef IS_GUI
    kitchenTransport();
// OPHONE HEAD TRANSPORT BEGIN
    // Reserved marker FA x y, with coordinates quantized to four canvas pixels.
    // Native object components retain the player's skin and hat on the client.
    ivec3 phoneColor=ivec3(round(Color.rgb*255.0));
    bool phoneSkin=textureSize(Sampler0,0)==ivec2(64,64);
    vec2 skinUV=UV0*64.0;
    bool faceX=abs(skinUV.x-8.0)<.001 || abs(skinUV.x-16.0)<.001;
    bool hatX=abs(skinUV.x-40.0)<.001 || abs(skinUV.x-48.0)<.001;
    bool headY=abs(skinUV.y-8.0)<.001 || abs(skinUV.y-16.0)<.001;
    if(hudInfo.x<0 && phoneColor.r==250 && phoneSkin && (faceX||hatX) && headY) {
        vec2 corner=vec2((skinUV.x-(hatX?40.0:8.0))/8.0,(skinUV.y-8.0)/8.0);
        vec2 origin=vec2(phoneColor.g,phoneColor.b)*4.0;
        float scale=min(ScreenSize.x/960.0,ScreenSize.y/540.0);
        vec2 screen=(ScreenSize-vec2(960,540)*scale)*.5+(origin+corner*28.0)*scale;
        gl_Position=vec4(screen.x/ScreenSize.x*2.0-1.0,1.0-screen.y/ScreenSize.y*2.0,0.0,1.0);
        vertexColor=vec4(1.0);
    }
// OPHONE HEAD TRANSPORT END

#endif
}
