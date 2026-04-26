<template>
  <header class="app-header">
    <div class="header-inner">
      <!-- Logo et nom de l'université -->
      <div class="header-brand">
        <div class="logo-box">
          <img :src="universityLogo" alt="Logo Université de Béjaïa" class="logo-image" />
        </div>
        <div class="brand-text">
          <h1 class="university-name">Université de Béjaïa</h1>
          <p class="portal-subtitle">Portail StudentVoice</p>
        </div>
      </div>

      <!-- Navigation -->
      <nav class="header-nav">
        <a :href="link.link" class="nav-link" v-for="link in navLinks" :key="link.title">
          <component :is="link.icon" :size="24" class="nav-icon" />
          <span class="nav-text">{{ link.title }}</span>
        </a>
      </nav>
    </div>

    <!-- Ligne de couleur -->
    <div class="header-bar"></div>
  </header>
</template>

<script setup>
import { ref } from 'vue'
import { Home, Info, Mail } from 'lucide-vue-next'
import universityLogo from '../Asset/university-logo-bejaia.png'

const navLinks = ref([
  { icon: Home, title: 'Accueil', link: '#hero' },
  { icon: Info, title: 'À propos', link: '#about' },
  { icon: Mail, title: 'Contact', link: '#contact' }
])
</script>

<style scoped>
.app-header {
  background: var(--white);
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
  position: sticky;
  top: 0;
  z-index: 100;
}

.header-inner {
  max-width: 1240px;
  margin: 0 auto;
  padding: 20px 40px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 48px;
}

/* Brand / Logo Section */
.header-brand {
  display: flex;
  align-items: center;
  gap: 14px;
  flex-shrink: 0;
}

.logo-box {
  width: 80px;
  height: 80px;
  background: var(--white);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  border: 2px solid var(--gray-100);
}

.logo-image {
  width: 100%;
  height: 100%;
  object-fit: contain;
  padding: 4px;
}

.brand-text {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.university-name {
  font-size: 22px;
  font-weight: 700;
  color: var(--gray-800);
  margin: 0;
  line-height: 1.2;
}

.portal-subtitle {
  font-size: 14px;
  color: var(--blue);
  margin: 0;
  font-weight: 600;
  letter-spacing: 0.3px;
}

/* Navigation */
.header-nav {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-left: auto;
}

.nav-link {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 16px;
  font-weight: 600;
  color: var(--gray-600);
  text-decoration: none;
  transition: all var(--transition);
  position: relative;
  padding: 10px 16px;
  border-radius: 10px;
  background: transparent;
  overflow: hidden;
}

.nav-link::before {
  content: '';
  position: absolute;
  inset: 0;
  background: rgba(37, 99, 235, 0.1);
  border-radius: 10px;
  transform: scaleX(0);
  transform-origin: left;
  transition: transform var(--transition);
  z-index: -1;
}

.nav-icon {
  transition: all var(--transition);
  color: var(--gray-600);
  z-index: 1;
  position: relative;
}

.nav-text {
  transition: all var(--transition);
  z-index: 1;
  position: relative;
}

.nav-link:hover {
  color: var(--blue);
  transform: translateY(-2px);
}

.nav-link:hover::before {
  transform: scaleX(1);
}

.nav-link:hover .nav-icon {
  color: var(--blue);
  transform: scale(1.1);
}

.nav-link.router-link-active {
  color: var(--blue);
}

.nav-link.router-link-active::before {
  transform: scaleX(1);
  background: rgba(37, 99, 235, 0.15);
}

.nav-link.router-link-active .nav-icon {
  color: var(--blue);
}

/* Header bar decoratif */
.header-bar {
  height: 3px;
  background: linear-gradient(90deg, var(--blue-deep), var(--blue), var(--blue-deep));
}

/* Responsive */
@media (max-width: 768px) {
  .header-inner {
    padding: 16px 20px;
    gap: 24px;
  }

  .logo-box {
    width: 56px;
    height: 56px;
  }

  .university-name {
    font-size: 17px;
  }

  .portal-subtitle {
    font-size: 12px;
  }

  .nav-link {
    font-size: 15px;
    gap: 6px;
  }
}

@media (max-width: 540px) {
  .header-inner {
    flex-direction: column;
    padding: 16px 16px;
    gap: 14px;
    text-align: center;
  }

  .header-brand {
    width: 100%;
    justify-content: center;
  }

  .header-nav {
    width: 100%;
    margin-left: 0;
    justify-content: center;
    gap: 12px;
  }

  .university-name {
    font-size: 16px;
  }

  .nav-link {
    font-size: 12px;
    padding: 6px 10px;
  }

  .nav-text {
    display: none;
  }
}
</style>
