attribute float aSize;
attribute vec3 aColor;
uniform float uTime;
varying vec3 vColor;
void main() {
    vec3 newPosition = position;
    newPosition.y += uTime * aSize * 0.005;
    newPosition.y = mod(newPosition.y, 20.0);
    newPosition.y -= 10.0;


    vec4 modelPosition = modelMatrix * vec4(newPosition, 1.0);
    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectedPosition = projectionMatrix * viewPosition;

    gl_Position = projectedPosition;
    gl_PointSize = aSize;
    gl_PointSize *= (1.0 / - viewPosition.z);

    // Varyings
    vColor = aColor;
}
