uniform vec3 uColor;

varying vec3 vNormal;
varying vec3 vPosition;
varying vec2 vUv;

void main() {
    vec2 uv = vUv;
    float d = distance(uv, vec2(0.5));
    float intensity = 1.0 - step(0.5, d);

    if (distance(vPosition, vec3(0.0)) < 10.0) {
        intensity = 0.0;
    }

    gl_FragColor = vec4(uColor, intensity);

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}
