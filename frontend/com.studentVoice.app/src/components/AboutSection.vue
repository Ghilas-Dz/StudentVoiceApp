<template>
  <section class="about-section">
    <div class="section-head sr-item sr-item-1">
      <h2>À Propos de la Plateforme</h2>
      <p>Une solution moderne pour faciliter la communication entre étudiants et administration</p>
    </div>
    <div class="features-grid">
      <div class="feature-card sr-item" v-for="f in features" :key="f.title">
        <div class="feature-icon" :style="{ backgroundColor: f.bgColor }">
          <component :is="f.icon" :size="28" :style="{ color: f.color }" />
        </div>
        <h3>{{ f.title }}</h3>
        <p>{{ f.desc }}</p>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref } from 'vue'
import { FileText, Eye, Lock } from 'lucide-vue-next'

const features = ref([
  {
    icon: FileText,
    title: 'Soumission Simplifiée',
    desc: 'Interface intuitive pour soumettre vos demandes en quelques clics.',
    color: '#3B82F6',
    bgColor: 'rgba(59, 130, 246, 0.1)'
  },
  {
    icon: Eye,
    title: 'Suivi en Temps Réel',
    desc: "Suivez l'évolution de votre dossier avec des mises à jour instantanées.",
    color: '#8B5CF6',
    bgColor: 'rgba(139, 92, 246, 0.1)'
  },
  {
    icon: Lock,
    title: 'Sécurité Garantie',
    desc: 'Vos données sont protégées par des protocoles de sécurité avancés.',
    color: '#10B981',
    bgColor: 'rgba(16, 185, 129, 0.1)'
  }
])
</script>

<style scoped>
.about-section {
  background: var(--white);
  padding: 80px 40px;
}

.section-head {
  text-align: center;
  margin-bottom: 56px;
}

.section-head h2 {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  font-size: clamp(28px, 3.5vw, 40px);
  font-weight: 800;
  color: var(--gray-800);
  margin-bottom: 10px;
  letter-spacing: -0.5px;
  line-height: 1.2;
}

.section-head p {
  font-size: 16px;
  color: var(--gray-600);
  max-width: 560px;
  margin: 0 auto;
  line-height: 1.65;
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 24px;
  max-width: 1100px;
  margin: 0 auto;
}

.feature-card {
  background: var(--gray-50);
  border: 1px solid var(--gray-200);
  border-radius: var(--radius);
  padding: 36px 28px;
  text-align: center;
  transition: var(--transition);
  cursor: default;
  position: relative;
  overflow: hidden;
}

.feature-card::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 3px;
  background: linear-gradient(90deg, var(--blue), var(--blue-dark));
  transform: scaleX(0);
  transition: transform var(--transition);
  transform-origin: left;
}

.feature-card:hover {
  transform: translateY(-6px);
  box-shadow: var(--shadow-lg);
  border-color: var(--blue-mid);
}

.feature-card:hover::after {
  transform: scaleX(1);
}

.feature-icon {
  width: 64px;
  height: 64px;
  margin: 0 auto 20px;
  background: var(--blue-light);
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 28px;
  transition: var(--transition);
}

.feature-card:hover .feature-icon {
  background: var(--blue);
}

.feature-card h3 {
  font-size: 17px;
  font-weight: 700;
  color: var(--gray-800);
  margin-bottom: 10px;
}

.feature-card p {
  font-size: 13.5px;
  color: var(--gray-600);
  line-height: 1.65;
}

@media (max-width: 768px) {
  .about-section {
    padding: 56px 20px;
  }
  .features-grid {
    grid-template-columns: 1fr;
  }
}
</style>
