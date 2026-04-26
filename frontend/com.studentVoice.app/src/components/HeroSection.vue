<template>
  <section class="hero">
    <div class="hero-left sr-item sr-item-1">
      <h1 class="hero-title">Portail <span>StudentVoice</span></h1>
      <p class="hero-desc">Votre solution digitale pour soumettre et suivre vos demandes académiques en toute simplicité.</p>
      <div class="hero-badges">
        <div class="badge" v-for="badge in badges" :key="badge.text" :style="{ borderColor: badge.color }">
          <component :is="badge.icon" :size="18" :style="{ color: badge.color }" />
          <span>{{ badge.text }}</span>
        </div>
      </div>
    </div>

    <div class="hero-right sr-item sr-item-2">
      <div class="login-showcase">
        <div class="login-card-preview">
          <div class="card-header">
            <div class="icon-box">
            <Lock :size="28" color="white" />
          </div>
            <h3>Accès Sécurisé</h3>
          </div>
          <div class="card-features">
            <div class="feature-item" v-for="item in cardFeatures" :key="item">
              <span class="check-icon">✓</span>
              <span>{{ item }}</span>
            </div>
          </div>
          <button @click="emit('navigate-to-login')" class="cta-button">
            <span>Accéder au Portail</span>
            <ArrowRight :size="18" class="arrow" />
          </button>
        </div>
        <div class="decoration">
          <div class="blob blob-1"></div>
          <div class="blob blob-2"></div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ShieldCheck, Zap, Headphones, Lock, ArrowRight } from 'lucide-vue-next'

const emit = defineEmits(['navigate-to-login'])

const badges = [
  { icon: ShieldCheck, text: '100% Sécurisé', color: '#10B981' },
  { icon: Zap, text: 'Suivi en temps réel', color: '#F59E0B' },
  { icon: Headphones, text: 'Support dédié', color: '#8B5CF6' }
]

const cardFeatures = [
  'Authentification sécurisée',
  'Données protégées',
  'Support 24/7'
]
</script>

<style scoped>
.hero {
  min-height: calc(100vh - 92px);
  background: linear-gradient(135deg, var(--blue-dark) 0%, var(--blue) 50%, var(--blue-deep) 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 60px 40px;
  gap: 64px;
  position: relative;
  overflow: hidden;
}

.hero::before {
  content: '';
  position: absolute;
  inset: 0;
  background:
    radial-gradient(ellipse at 15% 60%, rgba(255, 255, 255, 0.05) 0%, transparent 55%),
    radial-gradient(ellipse at 85% 15%, rgba(255, 255, 255, 0.04) 0%, transparent 45%);
}

.hero-left {
  flex: 1;
  max-width: 500px;
  z-index: 1;
}

.hero-title {
  font-family: 'Playfair Display', serif;
  font-size: clamp(30px, 3.8vw, 46px);
  font-weight: 800;
  color: var(--white);
  line-height: 1.15;
  margin-bottom: 20px;
}

.hero-title span {
  color: #a9cdff;
}

.hero-desc {
  font-size: 16px;
  color: rgba(255, 255, 255, 0.88);
  line-height: 1.75;
  margin-bottom: 36px;
  max-width: 420px;
}

.hero-badges {
  display: flex;
  flex-wrap: nowrap;
  
  gap: 12px;
}

.badge {
  display: flex;
  align-items: center;
  gap: 8px;
  background: rgba(255, 255, 255, 0.08);
  backdrop-filter: blur(10px);
  border: 1.5px solid;
  border-radius: 50px;
  padding: 10px 14px;
  font-size: 14px;
  font-weight: 600;
  color: var(--white);
  transition: var(--transition);
  cursor: default;
}

.badge:hover {
  background: rgba(255, 255, 255, 0.15);
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
}

.hero-right {
  flex-shrink: 0;
  z-index: 1;
  display: flex;
  align-items: center;
  justify-content: center;
}

.login-showcase {
  position: relative;
  width: 100%;
  max-width: 380px;
}

.login-card-preview {
  background: var(--white);
  border-radius: 20px;
  padding: 36px 28px;
  box-shadow: 0 24px 64px rgba(0, 0, 0, 0.2);
  position: relative;
  z-index: 2;
  transform: translateY(0);
  transition: transform var(--transition), box-shadow var(--transition);
}

.login-card-preview:hover {
  transform: translateY(-8px);
  box-shadow: 0 32px 80px rgba(0, 0, 0, 0.25);
}

.card-header {
  text-align: center;
  margin-bottom: 28px;
}

.icon-box {
  width: 60px;
  height: 60px;
  background: linear-gradient(135deg, var(--blue), var(--blue-dark));
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 28px;
  margin: 0 auto 16px;
  box-shadow: 0 8px 24px rgba(37, 99, 235, 0.3);
}

.card-header h3 {
  font-size: 22px;
  font-weight: 700;
  color: var(--gray-800);
  margin: 0;
}

.card-features {
  display: flex;
  flex-direction: column;
  gap: 14px;
  margin-bottom: 28px;
}

.feature-item {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 14px;
  color: var(--gray-600);
}

.check-icon {
  width: 24px;
  height: 24px;
  background: #e8f5e9;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #4caf50;
  font-size: 12px;
  flex-shrink: 0;
}

.cta-button {
  width: 100%;
  padding: 14px 24px;
  background: linear-gradient(135deg, var(--blue), var(--blue-dark));
  border: none;
  border-radius: 12px;
  color: var(--white);
  font-size: 15px;
  font-weight: 700;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  transition: var(--transition);
  box-shadow: 0 8px 24px rgba(37, 99, 235, 0.35);
}

.cta-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 12px 32px rgba(37, 99, 235, 0.45);
}

.cta-button:active {
  transform: translateY(0);
}

.arrow {
  transition: transform var(--transition);
}

.cta-button:hover .arrow {
  transform: translateX(4px);
}

.decoration {
  position: absolute;
  inset: 0;
  pointer-events: none;
}

.blob {
  position: absolute;
  border-radius: 50%;
  filter: blur(40px);
  opacity: 0.3;
}

.blob-1 {
  width: 200px;
  height: 200px;
  background: rgba(147, 197, 253, 0.4);
  top: -50px;
  right: -100px;
  animation: float 6s ease-in-out infinite;
}

.blob-2 {
  width: 150px;
  height: 150px;
  background: rgba(37, 99, 235, 0.3);
  bottom: -60px;
  left: -50px;
  animation: float 8s ease-in-out infinite reverse;
}

@keyframes float {
  0%, 100% { transform: translate(0, 0); }
  50% { transform: translate(30px, -30px); }
}

@media (max-width: 768px) {
  .hero {
    flex-direction: column;
    padding: 40px 20px;
    gap: 40px;
  }
  .hero-left {
    text-align: center;
    max-width: 100%;
  }
  .hero-desc {
    max-width: 100%;
  }
  .hero-badges {
    justify-content: center;
  }
}
</style>
