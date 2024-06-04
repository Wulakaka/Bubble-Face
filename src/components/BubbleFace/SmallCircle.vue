<script setup lang="ts">
import circleVertexShader from '@/shaders/circle/vertex.glsl'
import circleFragmentShader from '@/shaders/circle/fragment.glsl'
import * as THREE from 'three'
import { useRenderLoop } from '@tresjs/core'
import { ref } from 'vue'

const uniforms = {
  uSize: new THREE.Uniform(new THREE.Vector2(2, 2)),
  uCameraPosition: new THREE.Uniform(new THREE.Vector3(50, 0, 0)),
  uSphereRadius: new THREE.Uniform(10)
}

const { onLoop } = useRenderLoop()

onLoop(({ delta, elapsed }) => {
  // 将在每一帧运行 ~ 60FPS（取决于您的显示器）
  refMesh.value.position.y = -15 + ((elapsed * 2) % 30)
})

const refMesh = ref()
</script>

<template>
  <TresMesh :position="[0, 0, 0]" :rotate-y="Math.PI / 2" ref="refMesh">
    <TresPlaneGeometry :args="[2, 2, 16, 16]"></TresPlaneGeometry>
    <TresShaderMaterial
      :vertex-shader="circleVertexShader"
      :fragment-shader="circleFragmentShader"
      :transparent="true"
      :side="2"
      :uniforms="uniforms"
    ></TresShaderMaterial>
  </TresMesh>
</template>

<style scoped></style>
