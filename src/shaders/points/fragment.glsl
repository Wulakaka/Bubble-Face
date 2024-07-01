varying vec3 vColor;

#include ../includes/hsv2rgb_smooth.glsl

void main() {
    float distanceToCenter = distance(gl_PointCoord.xy, vec2(0.5));
    if (distanceToCenter > 0.5) {
        discard;
    }

    vec3 color = hsv2rgb_smooth(vColor);
    gl_FragColor = vec4(color, 1.0);

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}
