<template>
  <div class="min-h-screen w-full flex flex-col items-center justify-center relative overflow-hidden"
    :style="{
      background: 'linear-gradient(135deg, #122349 0%, #1e3a8a 50%, #2453d1 100%)',
      position: 'relative'
    }"
  >
    <!-- Bouton Retour -->
    <button
      @click="goToHome"
      class="absolute top-8 left-8 px-6 py-3 rounded-full font-semibold text-white transition-all duration-300 flex items-center gap-2 group hover:shadow-lg hover:shadow-blue-500/50 hover:scale-105 z-50"
      :style="{
        background: 'linear-gradient(135deg, #1e3a8a 0%, #2453d1 50%, #60a5fa 100%)',
        position: 'absolute',
        top: '32px',
        left: '32px'
      }"
    >
      <svg class="w-5 h-5 group-hover:-translate-x-1 transition-transform duration-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
      </svg>
      <span>Accueil</span>
    </button>

    <!-- Background image overlay -->
    <div
      class="absolute inset-0 opacity-5"
      :style="{
        backgroundImage: `url(https://images.unsplash.com/photo-1680444873773-7c106c23ac52?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx1bml2ZXJzaXR5JTIwY2FtcHVzJTIwbW9kZXJuJTIwYXJjaGl0ZWN0dXJlfGVufDF8fHx8MTc3MzY0OTAyNnww&ixlib=rb-4.0.0&q=80&w=1080)`,
        backgroundSize: 'cover',
        backgroundPosition: 'center',
      }"
    />

    <!-- Decorative blobs -->
    <div
      class="absolute top-[-10%] left-[-10%] w-[500px] h-[500px] rounded-full opacity-15"
      :style="{ background: 'radial-gradient(circle, #60a5fa, transparent)' }"
    />
    <div
      class="absolute bottom-[-10%] right-[-5%] w-[400px] h-[400px] rounded-full opacity-15"
      :style="{ background: 'radial-gradient(circle, #818cf8, transparent)' }"
    />

    <!-- Login Card -->
    <LoginCard />
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import LoginCard from '../../components/LoginCard.vue'

const router = useRouter()

const goToHome = () => {
  router.push('/home')
}
</script>
