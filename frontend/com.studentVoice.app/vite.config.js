import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue()],
  build: {
    // allow top-level await and modern syntax during production build
    target: 'esnext'
  }
})
