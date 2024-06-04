uniform vec2 uSize;

varying vec3 vNormal;
varying vec3 vPosition;
varying vec2 vUv;

void main() {
    vec2 uv = vUv;
    float d = distance(uv, vec2(0.5));
    float color = 1.0 - step(0.5, d);

    if (distance(vPosition, vec3(0.0)) < 10.0) {
        color = 0.0;
    }

    gl_FragColor = vec4(color, 0.0, 0.0, color);

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}
