<script setup lang="ts">
import circleVertexShader from '@/shaders/circle/vertex.glsl'
import circleFragmentShader from '@/shaders/circle/fragment.glsl'
import * as THREE from 'three'

const uniforms = {
  uSize: new THREE.Uniform(new THREE.Vector2(10, 10))
}
</script>

<template>
  <TresMesh :rotate-y="Math.PI / 2" :position="[0, 10, 0]">
    <TresPlaneGeometry :args="[10, 10, 16, 16]"></TresPlaneGeometry>
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
