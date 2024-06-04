uniform vec3 uCameraPosition;
uniform float uSphereRadius;
uniform vec3 uCircleCenter;
uniform float uCircleRadius;

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


void main() {
    vec3 normal = normalize(vNormal);
    vec3 viewDirection = normalize(cameraPosition - vPosition);

    float intensity = 1.0 - dot(normal, viewDirection);
    intensity = remap(intensity, 0.3, 0.9, 0.0, 1.0);
    // 让变暗的区域更柔和
    intensity = smoothstep(0.0, 1.0, intensity);
    intensity = clamp(intensity, 0.0, 1.0);
    intensity *= 0.5;
    vec4 color = vec4(1.0) * intensity;
    gl_FragColor = color;


    // 此 camera position 为最终锁定的摄像机位置
    vec3 cameraPos= uCameraPosition;
    float sphereRadius = uSphereRadius;
    vec3 sphereCenter = vec3(0.0);
    vec3 circleCenter = uCircleCenter;
    float circleRadius = uCircleRadius;
    // 折射点，也就是当前位置
    vec3 refractPosition = vPosition;

    vec3 viewDir = normalize(refractPosition - cameraPos); // 计算视线方向
//    vec3 normal = normalize(fragPos - sphereCenter); // 计算球面法线

    // 计算折射方向
    vec3 refractDir = refract(viewDir, normal, 0.9); // 假设折射率为0.7

    // 计算折射光线与圆心平面的交点
    float t = dot(circleCenter - refractPosition, normal) / dot(refractDir, normal);
    vec3 refractPoint = refractPosition + t * refractDir;

    // 检查折射点是否在圆内
    if (length(refractPoint - circleCenter) < circleRadius) {
        gl_FragColor = vec4(1, 0, 0, 1); // 在圆内部，显示红色
    } else {
//        gl_FragColor = vec4(0, 0, 1, 1); // 在圆外部，显示蓝色
    }



//    gl_FragColor = FragColor;

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}
