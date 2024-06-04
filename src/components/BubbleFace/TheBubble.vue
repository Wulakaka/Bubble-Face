<script setup lang="ts">
import bubbleVertexShader from '@/shaders/bubble/vertex.glsl'
import bubbleFragmentShader from '@/shaders/bubble/fragment.glsl'
import * as THREE from 'three'
import { useRenderLoop } from '@tresjs/core'

const uniforms = {
  uCircleY: new THREE.Uniform(0),
  uCameraPosition: new THREE.Uniform(new THREE.Vector3(50, 0, 0)),
  uSphereRadius: new THREE.Uniform(10),
  uCircleCenter: new THREE.Uniform(new THREE.Vector3(0, 0, 0)),
  uCircleRadius: new THREE.Uniform(1)
}

const { onLoop } = useRenderLoop()

onLoop(({ delta, elapsed }) => {
  // 将在每一帧运行 ~ 60FPS（取决于您的显示器）
  uniforms.uCircleCenter.value.y = -15 + ((elapsed * 2) % 30)
})
</script>

<template>
  <TresMesh>
    <TresSphereGeometry :args="[10, 32, 16]" />
    <TresShaderMaterial
      :transparent="true"
      :vertex-shader="bubbleVertexShader"
      :fragment-shader="bubbleFragmentShader"
      :uniforms="uniforms"
      :depth-write="false"
    />
  </TresMesh>
</template>

<style scoped></style>
