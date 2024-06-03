<script setup lang="ts">
import * as THREE from 'three'
const spherical = new THREE.Spherical(10, Math.PI / 2, 0)
const position = new THREE.Vector3()
position.setFromSpherical(spherical)
// console.log(position)
</script>

<template>
  <TresMesh :position="position" :look-at="[0, 0, 0]">
    <TresCircleGeometry :args="[1, 16]"></TresCircleGeometry>
    <TresMeshBasicMaterial :color="'red'" :side="2"></TresMeshBasicMaterial>
  </TresMesh>
</template>

<style scoped></style>
