<template>
  <div class="app-wrapper">
    <AppHeader />
    <section id="hero">
      <HeroSection @navigate-to-login="goToLogin" />
    </section>
    <section id="about">
      <AboutSection />
    </section>
    <section id="how-it-works">
      <HowItWorks />
    </section>
    <section id="contact">
      <AppFooter />
    </section>
  </div>
</template>

<script setup>
import { onMounted } from 'vue'
import AppHeader from '../../components/AppHeader.vue'
import HeroSection from '../../components/HeroSection.vue'
import AboutSection from '../../components/AboutSection.vue'
import HowItWorks from '../../components/HowItWorks.vue'
import AppFooter from '../../components/AppFooter.vue'
import { useScrollReveal } from '../../composables/useScrollReveal'
import { useRouter } from 'vue-router'
const router = useRouter()

// Initialiser Scroll Reveal
useScrollReveal()

const goToLogin = () => {
    router.push('/home/login')
}

// Force light mode for home page
onMounted(() => {
  const root = document.documentElement
  root.setAttribute('data-theme', 'light')
  root.classList.remove('dark')
})
</script>

<style scoped>
.app-wrapper {
  background: var(--white);
  color: var(--gray-800);
  scroll-behavior: smooth;
}

section {
  scroll-margin-top: 92px;
}
</style>
