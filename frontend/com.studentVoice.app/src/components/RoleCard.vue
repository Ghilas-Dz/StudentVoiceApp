<template>
  <button
    type="button"
    @click="$emit('click')"
    @mouseenter="hovered = true"
    @mouseleave="hovered = false"
    class="flex flex-col items-center gap-1.5 p-3.5 rounded-xl transition-all duration-250 text-center"
    :style="{
      border: active ? `2px solid ${color}` : hovered ? `2px solid ${color}66` : '2px solid #e2e8f0',
      background: active ? `${color}12` : hovered ? `${color}08` : '#f8fafc',
      cursor: 'pointer',
      transform: active ? 'scale(1.02)' : hovered ? 'scale(1.01)' : 'scale(1)',
      boxShadow: active ? `0 4px 16px ${color}30` : 'none',
      transition: 'all 0.22s ease',
    }"
  >
    <span :style="{ color: active ? color : hovered ? color : '#94a3b8', transition: 'color 0.22s' }"
      ><component :is="icon" :size="24" stroke-width="1.8" fill="currentColor" />
    </span>
    <span class="text-sm" :style="{ color: active ? color : '#334155', fontWeight: 700, transition: 'color 0.22s' }">{{ label }}</span>
    <span class="text-xs leading-tight" :style="{ color: '#94a3b8' }">{{ desc }}</span>
  </button>
</template>

<script setup>
import { computed, ref } from 'vue'

const props = defineProps({
  active: {
    type: Boolean,
    default: false
  },
  color: String,
  icon: [Object, Function],
  label: String,
  desc: String
})

const hovered = ref(false)
const active = computed(() => props.active)
</script>
