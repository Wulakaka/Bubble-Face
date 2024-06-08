<script setup lang="ts">
import faceVertexShader from '@/shaders/face/vertex.glsl'
import faceFragmentShader from '@/shaders/face/fragment.glsl'
</script>

<template>
  <TresMesh :scale="12" :rotate-y="Math.PI / 2" ref="refMesh">
    <TresPlaneGeometry :args="[1, 1, 16, 16]"></TresPlaneGeometry>
    <TresShaderMaterial
      :vertex-shader="faceVertexShader"
      :fragment-shader="faceFragmentShader"
      :transparent="true"
      :side="2"
      :depth-write="false"
    ></TresShaderMaterial>
  </TresMesh>
</template>

<style scoped></style>
