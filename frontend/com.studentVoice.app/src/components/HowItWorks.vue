<template>
  <section class="how-section">
    <div class="section-head sr-item sr-item-1">
      <h2>Comment ça Marche ?</h2>
      <p>Un processus simple en 4 étapes</p>
    </div>
    <div class="steps-grid">
      <div class="step-card sr-item" v-for="s in steps" :key="s.num">
        <div class="step-num">{{ s.num }}</div>
        <h3>{{ s.title }}</h3>
        <p>{{ s.desc }}</p>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref } from 'vue'

const steps = ref([
  {
    num: 1,
    title: 'Connexion',
    desc: 'Accédez à votre compte étudiant avec vos identifiants universitaires.'
  },
  {
    num: 2,
    title: 'Soumission',
    desc: 'Remplissez le formulaire StudentVoice avec tous les détails nécessaires.'
  },
  {
    num: 3,
    title: 'Validation',
    desc: "Votre demande est examinée et validée par l'administration."
  },
  {
    num: 4,
    title: 'Résolution',
    desc: 'Recevez une réponse et suivez la résolution de votre problème.'
  }
])
</script>

<style scoped>
.how-section {
  background: var(--gray-100);
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

.steps-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
  max-width: 1100px;
  margin: 0 auto;
  position: relative;
}

.step-card {
  background: var(--white);
  border: 1px solid var(--gray-200);
  border-radius: var(--radius);
  padding: 48px 28px 40px;
  text-align: center;
  position: relative;
  z-index: 1;
  transition: var(--transition);
}

.step-card:hover {
  transform: translateY(-6px);
  box-shadow: var(--shadow-lg);
  border-color: var(--blue-mid);
}

.step-num {
  width: 64px;
  height: 64px;
  border-radius: 50%;
  background: var(--blue);
  color: var(--white);
  font-size: 24px;
  font-weight: 800;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 24px;
  box-shadow: 0 4px 14px rgba(37, 99, 235, 0.35);
  transition: var(--transition);
}

.step-card:hover .step-num {
  transform: scale(1.12);
  background: var(--blue-dark);
}

.step-card h3 {
  font-size: 18px;
  font-weight: 700;
  color: var(--gray-800);
  margin-bottom: 12px;
}

.step-card p {
  font-size: 14px;
  color: var(--gray-600);
  line-height: 1.6;
}

@media (max-width: 1024px) {
  .steps-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  .steps-grid::before {
    display: none;
  }
}

@media (max-width: 768px) {
  .how-section {
    padding: 56px 20px;
  }
  .steps-grid {
    grid-template-columns: 1fr 1fr;
  }
}

@media (max-width: 540px) {
  .steps-grid {
    grid-template-columns: 1fr;
  }
}
</style>
