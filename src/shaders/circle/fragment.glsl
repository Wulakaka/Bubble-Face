uniform vec2 uSize;

varying vec3 vNormal;
varying vec3 vPosition;
varying vec2 vUv;

void main() {
    //    float color = distance(vUv, vec2(0.5));
    vec2 uv = vUv;

    float y = vPosition.y + uSize.y * uv.y;



    float d = distance(uv, vec2(0.5));
    float color = 1.0 - step(0.5, d);


    gl_FragColor = vec4(color);

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}
