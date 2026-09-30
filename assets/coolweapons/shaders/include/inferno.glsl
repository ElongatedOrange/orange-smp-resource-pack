// CoolWeapons plasma surface. Only textures with our reserved signature enter this code.
float inferno_hash(vec3 p) {
    p = fract(p * 0.3183099 + vec3(0.1, 0.3, 0.7));
    p *= 17.0;
    return fract(p.x * p.y * p.z * (p.x + p.y + p.z));
}
float inferno_noise(vec3 p) {
    vec3 i = floor(p), f = fract(p); f = f*f*(3.0-2.0*f);
    return mix(mix(mix(inferno_hash(i),inferno_hash(i+vec3(1,0,0)),f.x),
                   mix(inferno_hash(i+vec3(0,1,0)),inferno_hash(i+vec3(1,1,0)),f.x),f.y),
               mix(mix(inferno_hash(i+vec3(0,0,1)),inferno_hash(i+vec3(1,0,1)),f.x),
                   mix(inferno_hash(i+vec3(0,1,1)),inferno_hash(i+vec3(1,1,1)),f.x),f.y),f.z);
}
float inferno_fbm(vec3 p) {
    return .55*inferno_noise(p) + .27*inferno_noise(p*2.03+7.3) + .13*inferno_noise(p*4.11+16.7);
}
vec4 inferno_surface(vec3 p, float time, int kind) {
    vec3 flow = p * vec3(.5, .38, .5) + vec3(0.0, -time*1.8, time*.4);
    float warp = inferno_fbm(flow*.55);
    float flame = inferno_fbm(flow + vec3(warp*3.0, warp, -warp*2.0));
    float ridge = 1.0-abs(inferno_noise(flow*2.5 + warp*2.0)*2.0-1.0);
    float veins = pow(ridge, 19.0);
    float bands = pow(.5+.5*sin(p.y*3.0-p.z*1.4-time*7.0+warp*9.0), 14.0);
    // Keep a molten red body beneath thin hot fissures, so the anatomy survives at a distance.
    float heat = clamp(flame*.90+veins*.44+bands*.18,0.0,1.0);
    vec3 red = vec3(.23,.006,.002), orange = vec3(1.0,.15,.003), gold = vec3(1.0,.60,.025);
    vec3 color = mix(red,orange,smoothstep(.25,.57,heat));
    color = mix(color,gold,smoothstep(.59,.79,heat));
    color = mix(color,vec3(1.0,.95,.66),smoothstep(.82,.99,heat));
    float alpha = smoothstep(.12,.32,flame);
    if (kind == 1) { // Flame membranes are torn into translucent ribbons and fine white veins.
        alpha = .18 + max(veins*.58,smoothstep(.28,.65,flame)*.38);
        color = mix(vec3(.75,.035,.002),vec3(1.0,.64,.10),smoothstep(.32,.75,flame));
        color = mix(color,vec3(1.0,.88,.38),veins*.65);
    }
    if (kind == 2) { color = mix(vec3(1.0,.30,.005),vec3(1.0,.96,.65),.32+veins*.55); alpha=.95; }
    if (kind == 3) {
        float helix = pow(.5+.5*sin(atan(p.z,p.x)*6.0-p.y*.55+time*10.0),9.0);
        color = mix(color,vec3(1.0,.99,.85),helix*.85);
        alpha = .30+.65*smoothstep(.2,.7,flame+helix*.3);
    }
    return vec4(color,alpha);
}
