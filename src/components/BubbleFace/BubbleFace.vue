<script setup lang="ts">
import { TresCanvas } from '@tresjs/core'
import { OrbitControls } from '@tresjs/cientos'
import bubbleVertexShader from '@/shaders/bubble/vertex.glsl'
import bubbleFragmentShader from '@/shaders/bubble/fragment.glsl'
</script>

<template>
  <TresCanvas clear-color="black">
    <!-- Your scene here -->
    <TresPerspectiveCamera :args="[45, 1, 0.1, 1000]" />
    <TresMesh>
      <TresSphereGeometry :args="[1, 32, 16]" />
      <TresShaderMaterial
        :vertex-shader="bubbleVertexShader"
        :fragment-shader="bubbleFragmentShader"
      />
    </TresMesh>
    <TresAmbientLight :intensity="1" />
    <OrbitControls />
  </TresCanvas>
</template>
