<template>
  <button
    type="submit"
    :disabled="loading"
    @mouseenter="hovered = true"
    @mouseleave="hovered = false"
    class="w-full py-3.5 rounded-xl transition-all duration-250"
    :style="{
      background: gradient ?? (hovered
        ? 'linear-gradient(135deg,#1f54d2,#255fe3)'
        : 'linear-gradient(135deg,#255fe3,#3b7af0)'),
      color: 'white',
      fontWeight: 600,
      fontSize: '0.93rem',
      border: 'none',
      cursor: loading ? 'not-allowed' : 'pointer',
      boxShadow: hovered ? '0 10px 28px rgba(37,99,235,0.45)' : '0 6px 18px rgba(37,99,235,0.28)',
      transform: hovered ? 'translateY(-1px)' : 'translateY(0)',
      opacity: loading ? 0.75 : 1,
      transition: 'all 0.22s ease',
      letterSpacing: '0.02em',
    }"
  >
    <span v-if="loading" class="flex items-center justify-center gap-2">
      <svg class="animate-spin" width="17" height="17" viewBox="0 0 24 24" fill="none">
        <circle cx="12" cy="12" r="10" stroke="rgba(255,255,255,0.3)" stroke-width="3" />
        <path d="M12 2a10 10 0 0110 10" stroke="white" stroke-width="3" stroke-linecap="round" />
      </svg>
      En cours…
    </span>
    <span v-else class="flex items-center justify-center gap-2">
      {{ label }}
      <component :is="icon" :size="20" stroke-width="2" />
    </span>
  </button>
</template>

<script setup>
import { ref } from 'vue'

defineProps({
  label: String,
  loading: Boolean,
  icon: [Object, Function],
  gradient: String
})

const hovered = ref(false)
</script>
