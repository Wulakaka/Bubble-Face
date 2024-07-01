<script setup lang="ts">
import pointsVertexShader from '@/shaders/points/vertex.glsl'
import pointsFragmentShader from '@/shaders/points/fragment.glsl'
import * as THREE from 'three'
import { useRenderLoop } from '@tresjs/core'
import { onMounted, shallowRef } from 'vue'

const count = 100
const positions = new Float32Array(count * 3)
const colors = new Float32Array(count * 3)
const sizes = new Float32Array(count)
for (let i = 0; i < count; i++) {
  const i3 = i * 3
  positions[i3] = (Math.random() - 0.5) * 6
  positions[i3 + 1] = (Math.random() - 0.5) * 6
  positions[i3 + 2] = -4.5 + Math.random() * 0.1

  colors[i3] = Math.random()
  colors[i3 + 1] = 1
  colors[i3 + 2] = 1

  sizes[i] = Math.random() * 1000
}

const geometry = shallowRef()

onMounted(() => {
  geometry.value.setAttribute('position', new THREE.BufferAttribute(positions, 3))
  geometry.value.setAttribute('aColor', new THREE.BufferAttribute(colors, 3))
  geometry.value.setAttribute('aSize', new THREE.BufferAttribute(sizes, 1))
})

// Material
const uniforms = {
  uTime: new THREE.Uniform(0)
}

const { onLoop } = useRenderLoop()

onLoop(({ delta, elapsed }) => {
  // 将在每一帧运行 ~ 60FPS（取决于您的显示器）
  uniforms.uTime.value = elapsed
})
</script>

<template>
  <TresPoints>
    <TresBufferGeometry ref="geometry"></TresBufferGeometry>
    <TresShaderMaterial
      :fragment-shader="pointsFragmentShader"
      :vertex-shader="pointsVertexShader"
      :uniforms="uniforms"
    ></TresShaderMaterial>
  </TresPoints>
</template>

<style scoped></style>
