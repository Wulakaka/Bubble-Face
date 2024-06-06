uniform vec3 uColor;
uniform float uSphereRadius;

varying vec3 vNormal;
varying vec3 vPosition;
varying vec2 vUv;

float pointLineDistance(vec3 point, vec3 linePoint, vec3 lineDirection) {
    vec3 vector = point - linePoint;
    vec3 crossProduct = cross(vector, lineDirection);
    float distance = length(crossProduct) / length(lineDirection);
    return distance;
}

bool intersectSphere(vec3 cameraPosition, vec3 position, vec3 sphereCenter, float sphereRadius) {
    vec3 cameraDireciton =  position - cameraPosition;
    vec3 sphereDirection = sphereCenter - cameraPosition;
    // cross 方法是叉积，数值上 是 |a|*|b|*sin(theta)，方向是垂直于 a 与 b 形成的平面的向量
    float dis = length(cross(cameraDireciton, sphereDirection)) / length(cameraDireciton);

    return dis < sphereRadius;
}

void main() {
    vec2 uv = vUv;
    float d = distance(uv, vec2(0.5));
    float intensity = 1.0 - step(0.5, d);

    if (intersectSphere(cameraPosition, vPosition, vec3(0.0), uSphereRadius)) {
        intensity = 0.0;
    }

    gl_FragColor = vec4(uColor, intensity);

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}
