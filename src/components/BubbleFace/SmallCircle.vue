<script setup lang="ts">
import circleVertexShader from '@/shaders/circle/vertex.glsl'
import circleFragmentShader from '@/shaders/circle/fragment.glsl'
import * as THREE from 'three'
import { useRenderLoop } from '@tresjs/core'
import { ref } from 'vue'
import circleRefractVertexShader from '@/shaders/circleRefract/vertex.glsl'
import circleRefractFragmentShader from '@/shaders/circleRefract/fragment.glsl'

const props = defineProps<{
  r: number
  y: number
  z: number
  speed: number
}>()

const h = Math.random()
const color = new THREE.Color().setHSL(h, 1, 0.5)

const circleCenterX = -10

const uniforms = {
  uCameraPosition: new THREE.Uniform(new THREE.Vector3(30, 0, 0)),
  uSphereRadius: new THREE.Uniform(10),
  uCircleCenter: new THREE.Uniform(new THREE.Vector3(circleCenterX, 0, props.z)),
  uCircleRadius: new THREE.Uniform(props.r),
  uColor: new THREE.Uniform(color)
}

const { onLoop } = useRenderLoop()

onLoop(({ delta, elapsed }) => {
  // 将在每一帧运行 ~ 60FPS（取决于您的显示器）
  const y = -15 + ((elapsed * props.speed) % 30) + props.y
  refMesh.value.position.y = y
  uniforms.uCircleCenter.value.y = y
  uniforms.uColor.value.setHSL((elapsed * 0.05 + h) % 1, 1, 0.5)
})

const refMesh = ref()
</script>

<template>
  <TresMesh :position="[circleCenterX, 0, z]" :rotate-y="Math.PI / 2" ref="refMesh">
    <TresPlaneGeometry :args="[r * 2, r * 2, 16, 16]"></TresPlaneGeometry>
    <TresShaderMaterial
      :vertex-shader="circleVertexShader"
      :fragment-shader="circleFragmentShader"
      :transparent="true"
      :side="2"
      :depth-write="false"
      :uniforms="uniforms"
    ></TresShaderMaterial>
  </TresMesh>
  <TresMesh>
    <TresSphereGeometry :args="[10, 32, 16]" />
    <TresShaderMaterial
      :transparent="true"
      :vertex-shader="circleRefractVertexShader"
      :fragment-shader="circleRefractFragmentShader"
      :uniforms="uniforms"
      :depth-write="false"
      :side="2"
    />
  </TresMesh>
</template>

<style scoped></style>
