uniform vec3 uCameraPosition;
uniform float uSphereRadius;

varying vec3 vNormal;
varying vec3 vPosition;
varying vec2 vUv;

void main() {
    vec4 modelPositon = modelMatrix * vec4(position, 1.0);
    // model normal
    vec3 modelNormal = (modelMatrix * vec4(normal, 0.0)).xyz;

    vec4 viewPosition = viewMatrix * modelPositon;
    vec4 projectedPosition = projectionMatrix * viewPosition;

    gl_Position = projectedPosition;



    // varyings
    vNormal = modelNormal;
    vPosition = modelPositon.xyz;
    vUv = uv;
}
