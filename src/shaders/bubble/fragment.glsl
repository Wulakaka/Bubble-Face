varying vec3 vNormal;
varying vec3 vPosition;

#include ../includes/pointLight.glsl
#include ../includes/ambientLight.glsl

float remap(float value, float originMin, float originMax, float destinationMin, float destinationMax)
{
    return destinationMin + (value - originMin) * (destinationMax - destinationMin) / (originMax - originMin);
}

// 计算由 vecA 定义的锥体与从原点出发的 vecB 的交点
vec3 coneIntersectionFromOrigin(vec3 position, vec3 vecA, vec3 vecB, float theta) {
    vec3 unitA = normalize(vecA);
    vec3 unitB = normalize(vecB);
    float cosTheta = cos(theta);

    // 参数化 vecB
    // t * vecB = P(t)

    // 锥体方程：dot(unitA, normalize(P(t) - position)) = cosTheta
    // 展开并解 t
    float t = (cosTheta * length(position) - dot(unitA, position)) / dot(unitA, vecB);

    // 计算交点
    vec3 intersection = t * vecB;
    return intersection;
}
// 计算由 vecA 定义的锥体与从原点出发的 vecB 的交点
float coneIntersectionFromOrigin2(vec3 position, vec3 vecA, vec3 vecB, float theta) {
    vec3 unitA = normalize(vecA);
    vec3 unitB = normalize(vecB);
    float cosTheta = cos(theta);

    // 参数化 vecB
    // t * vecB = P(t)

    // 锥体方程：dot(unitA, normalize(P(t) - position)) = cosTheta
    // 展开并解 t
    float t = (cosTheta * length(position) - dot(unitA, position)) / dot(unitA, vecB);

    return t;
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

    vec3 direction = vec3(30.0, 0.0, 0.0) - vPosition;
    direction = normalize(direction);
    float theta = dot(direction, normal);
    theta = acos(theta);
    theta = sin(theta);
    float rate = 1.7;
    theta *= rate;
    theta = asin(theta);
//    theta = cos(theta);
    vec3 intersection = coneIntersectionFromOrigin(vPosition, normal, normalize(vec3(0.0, vPosition.y, vPosition.z)), theta);
    float d = distance(intersection, vec3(0.0,-10.0,0.0));

    vec4 color = vec4(1.0) * intensity;
    if(d < 10.0) {
        color = vec4(1.0, 0.0, 0.0, 1.0);
    }



    gl_FragColor = color;

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}
