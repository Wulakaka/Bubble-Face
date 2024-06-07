varying vec3 vNormal;
varying vec3 vPosition;


float remap(float value, float originMin, float originMax, float destinationMin, float destinationMax)
{
    return destinationMin + (value - originMin) * (destinationMax - destinationMin) / (originMax - originMin);
}



void main() {
    vec3 normal = normalize(vNormal);
    vec3 viewDirection = normalize(cameraPosition - vPosition);

    float intensity = 1.0 - dot(normal, viewDirection);
    // 让变暗的区域更柔和
    intensity = smoothstep(0.0, 1.0, intensity);
    intensity = pow(intensity, 3.0);
    intensity *= 0.7;
    vec4 color = vec4(1.0) * intensity;

    gl_FragColor = color;

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}
