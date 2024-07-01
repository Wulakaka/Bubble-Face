<script setup lang="ts">
import { TresCanvas } from '@tresjs/core'
import { OrbitControls } from '@tresjs/cientos'
import ThePoints from '@/components/BubbleFace2/ThePoints.vue'
</script>

<template>
  <TresCanvas clear-color="black" shadows>
    <TresPerspectiveCamera :args="[45, 1, 0.1, 1000]" :position="[10, 3, 10]" />
    <TresAmbientLight color="white" intensity="1"></TresAmbientLight>
    <TresDirectionalLight :position="[0, 10, 10]" intensity="10" cast-shadow></TresDirectionalLight>
    <TresMesh cast-shadow>
      <TresSphereGeometry :args="[3]"></TresSphereGeometry>
      <TresMeshPhysicalMaterial
        color="white"
        :transmission="1"
        :roughness="0"
        transparent
        :ior="1.5"
        :metalness="0"
        :thickness="1.5"
      ></TresMeshPhysicalMaterial>
    </TresMesh>
    <TresMesh :position="[0, -4, -5]" receive-shadow>
      <TresPlaneGeometry :args="[10, 10, 10, 10]"></TresPlaneGeometry>
      <TresMeshPhysicalMaterial></TresMeshPhysicalMaterial>
    </TresMesh>
    <ThePoints />
    <OrbitControls />
  </TresCanvas>
</template>

<style scoped></style>
