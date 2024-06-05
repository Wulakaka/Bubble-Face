<script setup lang="ts">
import { TresCanvas } from '@tresjs/core'
import { OrbitControls } from '@tresjs/cientos'
import TheBubble from '@/components/BubbleFace/TheBubble.vue'
import SmallCircle from '@/components/BubbleFace/SmallCircle.vue'

const list = new Array(10).fill(null).map(() => ({
  r: Math.random() * 2,
  y: Math.random() * 4 - 2,
  z: Math.random() * 20 - 10,
  speed: Math.random() * 10 + 2
}))
</script>

<template>
  <TresCanvas clear-color="black">
    <!-- Your scene here -->
    <TresPerspectiveCamera :args="[45, 1, 0.1, 1000]" :position="[50, 0, 0]" />
    <TheBubble />
    <SmallCircle v-for="(i, index) in list" v-bind="i" :key="index" />
    <OrbitControls />
  </TresCanvas>
</template>
