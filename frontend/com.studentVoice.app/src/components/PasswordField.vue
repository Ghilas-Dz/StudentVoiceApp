<template>
  <div class="flex flex-col" :style="{ paddingTop: '18px' }">
    <div class="relative flex items-end">
      <!-- Icon -->
      <span
        class="flex-shrink-0 pb-2 pr-2.5 transition-colors duration-250"
        :style="{ color: focused ? 'var(--primary)' : 'var(--muted-foreground)' }"
      >
        <Lock :size="20" stroke-width="1.8" />
      </span>

      <!-- Input + floating label -->
      <div class="relative flex-1">
        <label
          :for="id"
          class="absolute pointer-events-none"
          :style="{
            left: 0,
            top: active ? '-14px' : '8px',
            fontSize: active ? '0.7rem' : '0.85rem',
            color: focused ? 'var(--primary)' : 'var(--muted-foreground)',
            fontWeight: 600,
            letterSpacing: active ? '0.07em' : '0.02em',
            textTransform: active ? 'uppercase' : 'none',
            transition: 'all 0.25s cubic-bezier(0.4,0,0.2,1)',
          }"
        >
          {{ label }}
        </label>
        <input
          :id="id"
          :type="show ? 'text' : 'password'"
          :value="modelValue"
          @input="emit('update:modelValue', $event.target.value)"
          @focus="focused = true"
          @blur="focused = false"
          class="w-full bg-transparent pb-2 pt-1 outline-none text-sm input-clean"
          :style="{
            color: '#1e293b',
            border: 'none',
            outline: 'none',
            boxShadow: 'none',
            background: 'transparent',
            WebkitAppearance: 'none',
            appearance: 'none',
          }"
        />
      </div>

      <!-- Eye toggle -->
      <button
        type="button"
        @click="show = !show"
        class="pb-2 pl-2 flex-shrink-0 transition-colors duration-200"
        :style="{ color: '#94a3b8', background: 'none', border: 'none', cursor: 'pointer' }"
        @mouseenter="(e) => (e.currentTarget.style.color = '#2563eb')"
        @mouseleave="(e) => (e.currentTarget.style.color = '#94a3b8')"
      >
        <Eye v-if="show" :size="20" stroke-width="1.8" />
        <EyeOff v-else :size="20" stroke-width="1.8" />
      </button>
    </div>

    <!-- Animated underline -->
    <div :style="{ position: 'relative', height: '2px', background: '#e2e8f0' }">
      <div
        :style="{
          position: 'absolute',
          bottom: 0,
          left: 0,
          height: '2px',
          width: focused ? '100%' : '0%',
          background: 'linear-gradient(90deg,#2563eb,#60a5fa)',
          transition: 'width 0.3s cubic-bezier(0.4,0,0.2,1)',
        }"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { Lock, Eye, EyeOff } from 'lucide-vue-next'

const props = defineProps({
  id: String,
  label: String,
  modelValue: String
})

const emit = defineEmits([
  'update:modelValue'
])

const focused = ref(false)
const show = ref(false)
const active = computed(() => focused.value || (props.modelValue?.length ?? 0) > 0)
</script>

<style scoped>
.input-clean,
.input-clean:focus,
.input-clean:focus-visible {
  border: none !important;
  outline: none !important;
  box-shadow: none !important;
  background: transparent !important;
  -webkit-appearance: none;
  appearance: none;
}

.input-clean:-webkit-autofill,
.input-clean:-webkit-autofill:hover,
.input-clean:-webkit-autofill:focus {
  -webkit-text-fill-color: #1e293b;
  box-shadow: 0 0 0 1000px transparent inset !important;
  transition: background-color 9999s ease-in-out 0s;
}
</style>
