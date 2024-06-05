<script setup lang="ts">
import bubbleVertexShader from '@/shaders/bubble/vertex.glsl'
import bubbleFragmentShader from '@/shaders/bubble/fragment.glsl'
</script>

<template>
  <TresMesh>
    <TresSphereGeometry :args="[10, 32, 16]" />
    <TresShaderMaterial
      :transparent="true"
      :vertex-shader="bubbleVertexShader"
      :fragment-shader="bubbleFragmentShader"
      :depth-write="false"
    />
  </TresMesh>
</template>

<style scoped></style>
