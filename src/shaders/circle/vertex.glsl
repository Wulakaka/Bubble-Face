uniform vec3 uCameraPosition;
uniform float uSphereRadius;

varying vec3 vNormal;
varying vec3 vPosition;
varying vec2 vUv;


vec3 calculateRaySphereIntersection(vec3 position, vec3 direction, float radius, out bool hasIntersection) {
    float a = dot(direction, direction);
    float b = 2.0 * dot(position, direction);
    float c = dot(position, position) - radius * radius;

    float delta = b * b - 4.0 * a * c;

    if (delta < 0.0) {
        hasIntersection = false;
        return vec3(0.0); // 返回零向量或其他特殊值表示无交点
    } else {
        float t1 = (-b - sqrt(delta)) / (2.0 * a);
        float t2 = (-b + sqrt(delta)) / (2.0 * a);
        float t = min(t1, t2);
        if (t > 0.0) {
            hasIntersection = true;
            return position + t * direction; // 返回交点位置
        } else {
            hasIntersection = false;
            return vec3(0.0); // 光线起点在球内部或交点在光线起点后方
        }
    }
}
void main() {
    vec4 modelPositon = modelMatrix * vec4(position, 1.0);
    // model normal
    vec3 modelNormal = (modelMatrix * vec4(normal, 0.0)).xyz;

    // 从摄像机看向原始点
    vec3 direction = modelPositon.xyz - uCameraPosition;
    direction = normalize(direction);

    bool hit;
    vec3 intersection = calculateRaySphereIntersection(uCameraPosition, direction, uSphereRadius, hit);

    if (hit) {
        // 处理交点
        modelPositon = vec4(intersection, modelPositon.a);
//        vec3 normal = normalize(intersection);
//        vec3 refractDirection = refract(direction, normal, 0.7);
//        float t = dot(direction, normal) / dot(refractDirection, normal);
//        vec3 intersectPosition = modelPositon.xyz + refractDirection * t;
//
//        modelPositon = vec4(intersectPosition, modelPositon.a);

//        bool hit2;
//        vec3 intersection2 = calculateRaySphereIntersection(uCameraPosition, intersectPosition, uSphereRadius, hit2);
//        if(hit2) {
//            modelPositon = vec4(intersection2, modelPositon.a);
//        }


    } else {
        // 处理无交点的情况
    }










    vec4 viewPosition = viewMatrix * modelPositon;
    vec4 projectedPosition = projectionMatrix * viewPosition;

    gl_Position = projectedPosition;



    // varyings
    vNormal = modelNormal;
    vPosition = modelPositon.xyz;
    vUv = uv;
}
