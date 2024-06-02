varying vec3 vNormal;
varying vec3 vPosition;

#include ../includes/pointLight.glsl
#include ../includes/ambientLight.glsl

float remap(float value, float originMin, float originMax, float destinationMin, float destinationMax)
{
    return destinationMin + (value - originMin) * (destinationMax - destinationMin) / (originMax - originMin);
}



void main() {
    vec3 normal = normalize(vNormal);
    vec3 viewDirection = normalize(cameraPosition - vPosition);


    vec3 light = vec3(0.0);

//    light += ambientLight(
//    vec3(1.0),  // light color
//    0.03        // light intensity
//    );

//    light += pointLight(
//        vec3(1.0, 1.0, 1.0),    // light color
//        1.0,                    // light intensity
//        vNormal,                // normal
//        vec3(0.0, 2.5, 0.0),    // light position
//        viewDirection,        // View direction
//        30.0,                 // Specular power
//        vPosition,            // Position
//        0.1                     // light decay 光线衰减
//    );

    float intensity = 1.0 - dot(normal, viewDirection);
    intensity = remap(intensity, 0.3, 0.9, 0.0, 1.0);
    // 让变暗的区域更柔和
    intensity = smoothstep(0.0, 1.0, intensity);
    intensity = clamp(intensity, 0.0, 1.0);
    intensity *= 0.5;

    vec4 color = vec4(1.0) * intensity ;



    gl_FragColor = color;

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}
