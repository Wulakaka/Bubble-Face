varying vec3 vNormal;
varying vec3 vPosition;
varying vec2 vUv;

float drawRoundedRect (vec2 uv, vec2 size, float r) {
    vec2 newUv = uv - vec2(0.5, 0.5);
    float d = 0.0;
    d += step(distance(newUv, size / 2.0 - vec2(r, r)), r);
    d += step(distance(newUv, -size / 2.0 + vec2(r, r)), r);
    d += step(distance(newUv, vec2(-size.x / 2.0 + r, size.y / 2.0 - r)), r);
    d += step(distance(newUv, vec2(size.x / 2.0 - r, -size.y / 2.0 + r)), r);
    d += (1.0 - step(size.x / 2.0, abs(newUv.x))) * (1.0 - step(size.y / 2.0, abs(newUv.y)));
    //    d *= 1.0 - step(size.y / 2.0 - r, abs(newUv.y));
    return d;
}


void main() {
    vec2 uv = vUv;
    //    float r = 0.1;
    //    float intensity = drawRoundedRect(uv, vec2(0.8, 0.6), r);

    // 渐变
    float gradient =0.5 - distance(uv, vec2(0.5, 0.5));
    gradient = smoothstep(0.0, 0.25, gradient);
    float alpha = gradient;

    gradient = pow(gradient, 3.0);

    // 点阵
    float split = 100.0;
    // 最远处 edge 为 0.5，最近处 edge 为 1.0
    // 无色区域从 0.5 * 0.5 的方块过渡为两个 0.5 * 1.0 的矩形构成的 L 形
    float edge = 1.0 - gradient * 0.5;
    uv *= split;
    uv = mod(uv, 1.0);
    float colorX = 1.0 - step(edge, uv.x);
    float colorY = 1.0 - step(0.5, uv.y);
    float color1 = colorX * colorY;
    float color2 = (1.0 -step(0.5, uv.x))* (1.0 - step(edge, uv.y));
    float color = color1 + color2;
    color = 1.0 - clamp(color, 0.0, 1.0);

    gl_FragColor = vec4(vec3(color), alpha);

    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}
