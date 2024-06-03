<script setup lang="ts">
import { TresCanvas } from '@tresjs/core'
import { OrbitControls } from '@tresjs/cientos'
import TheBubble from '@/components/BubbleFace/TheBubble.vue'
import SmallCircle from '@/components/BubbleFace/SmallCircle.vue'
import TestCircle from '@/components/BubbleFace/TestCircle.vue'
</script>

<template>
  <TresCanvas clear-color="black">
    <!-- Your scene here -->
    <TresPerspectiveCamera :args="[45, 1, 0.1, 1000]" :position="[30, 0, 0]" />
    <TheBubble />
    <TestCircle />
    <SmallCircle />
    <OrbitControls />
  </TresCanvas>
</template>
