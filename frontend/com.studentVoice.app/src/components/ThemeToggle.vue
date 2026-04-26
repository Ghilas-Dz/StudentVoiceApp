<template>
  <button
    class="theme-toggle"
    type="button"
    role="switch"
    :aria-checked="String(isDark)"
    :aria-label="isDark ? 'Activer le mode clair' : 'Activer le mode sombre'"
    @click="toggleTheme"
  >
    <span class="track">
      <Sun class="icon sun" />
      <Moon class="icon moon" />
      <span class="thumb" :class="{ 'is-dark': isDark }" />
    </span>
  </button>
</template>
<script setup>
import { onMounted, ref } from 'vue'
import { Moon, Sun } from 'lucide-vue-next'

const STORAGE_KEY = 'theme'
const isDark = ref(false)

function applyTheme(theme) {
  const root = document.documentElement
  root.setAttribute('data-theme', theme)
  root.classList.toggle('dark', theme === 'dark')
  localStorage.setItem(STORAGE_KEY, theme)
  isDark.value = theme === 'dark'
}

function resolveInitialTheme() {
  const stored = localStorage.getItem(STORAGE_KEY)
  if (stored === 'dark' || stored === 'light') return stored
  return window.matchMedia('(prefers-color-scheme: dark)').matches
    ? 'dark'
    : 'light'
}

function toggleTheme() {
  applyTheme(isDark.value ? 'light' : 'dark')
}

onMounted(() => {
  applyTheme(resolveInitialTheme())
})
</script>
<style scoped>
.theme-toggle {
  border: none;
  background: transparent;
  cursor: pointer;
  padding: 0;
}

/* Track (pill) */
.track {
  position: relative;
  width: 52px;
  height: 28px;
  border-radius: 999px;
  background: var(--switch-background);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 6px;
  transition: background 0.3s ease;
}



/* Icons */
.icon {
  width: 14px;
  height: 14px;
  z-index: 1;
  opacity: 0.6;
}

.sun , .moon {
  color: black;
}


/* Thumb (le rond qui bouge) */
.thumb {
  position: absolute;
  top: 3px;
  left: 3px;
  width: 22px;
  height: 22px;
  border-radius: 50%;
  background: white;
  box-shadow: 0 2px 6px rgba(0,0,0,0.2);
  transition: transform 0.3s ease;
}

/* Position DARK */
.thumb.is-dark {
  transform: translateX(24px);
}

/* Focus */
.theme-toggle:focus-visible .track {
  outline: 2px solid #3b82f6;
  outline-offset: 2px;
}
</style>
