uniform vec3 uCameraPosition;
uniform float uSphereRadius;
uniform vec3 uCircleCenter;
uniform float uCircleRadius;
uniform vec3 uColor;

varying vec3 vNormal;
varying vec3 vPosition;

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

// 计算是否位于目标区域内
bool isInsideCone(vec3 circleCenter, float circleRadius) {

    vec3 cameraPos = uCameraPosition;
    float sphereRadius = uSphereRadius;
    vec3 sphereCenter = vec3(0.0);
    vec3 refractPosition = vPosition;

    vec3 viewDir = normalize(refractPosition - cameraPos);// 计算视线方向
    vec3 normal = normalize(refractPosition - sphereCenter);// 计算球面法线

    // 计算折射方向
    vec3 refractDir = refract(viewDir, normal, 0.9);// 假设折射率为0.7

    // 计算折射光线与圆心平面的交点
    float t = dot(circleCenter - refractPosition, normal) / dot(refractDir, normal);
    vec3 refractPoint = refractPosition + t * refractDir;

    // 检查折射点是否在圆内
    if (length(refractPoint - circleCenter) < circleRadius) {
        // 夹角小于九十度才显示
        if (dot(viewDir, normal) < 0.0) {
            return true;// 在圆内部，显示红色
        }
    }
    return false;

}


void main() {
    vec3 normal = normalize(vNormal);
    vec3 viewDirection = normalize(cameraPosition - vPosition);

    vec4 color = vec4(0);

    if (isInsideCone(uCircleCenter, uCircleRadius)) {
        color = vec4(uColor, 1.0);
    }

    gl_FragColor = color;

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}