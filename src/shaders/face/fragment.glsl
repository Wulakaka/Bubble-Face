
varying vec3 vNormal;
varying vec3 vPosition;
varying vec2 vUv;

float drawRoundedRect (vec2 uv, vec2 size, float r) {
    vec2 newUv = uv - vec2(0.5, 0.5);
    float d = 0.0;
    d += step(distance(newUv, size / 2.0 - vec2(r, r)), r);
    d += step(distance(newUv, -size / 2.0 + vec2(r, r)), r);
    d += step(distance(newUv, vec2(-size.x / 2.0 + r, size.y / 2.0 - r)), r);
    d += step(distance(newUv, vec2(size.x / 2.0 - r, -size.y / 2.0 + r)), r);
    d += (1.0 - step(size.x / 2.0 , abs(newUv.x))) * (1.0 - step(size.y / 2.0 , abs(newUv.y)));
//    d *= 1.0 - step(size.y / 2.0 - r, abs(newUv.y));
    return d;
}


void main() {
    vec2 uv = vUv;
    float r = 0.1;
    float intensity = drawRoundedRect(uv, vec2(0.8, 0.6), r);



    gl_FragColor = vec4(intensity);

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}
