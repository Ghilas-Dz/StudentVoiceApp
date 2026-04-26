<template>
  <div class="flex flex-col gap-6 w-full max-w-4xl mx-auto py-6">
    <!-- Contact Cards -->
    <div class="grid grid-cols-3 gap-4">
      <div
        v-for="item in contactItems"
        :key="item.label"
        class="help-card rounded-2xl p-4 flex flex-col items-center gap-2 text-center cursor-pointer transition-all hover:shadow-md"
      >
        <div class="w-10 h-10 rounded-xl flex items-center justify-center" :style="{ background: item.bg }">
          <component :is="item.icon" class="w-5 h-5" :style="{ color: item.color }" />
        </div>
        <p class="help-title text-sm">{{ item.label }}</p>
        <p class="help-subtitle text-xs">{{ item.sub }}</p>
      </div>
    </div>

    <!-- FAQ -->
    <div class="help-card rounded-2xl overflow-hidden">
      <div class="flex items-center gap-2 px-5 py-4 border-b help-border">
        <HelpCircle class="w-4 h-4 text-indigo-500" />
        <h3 class="help-title text-base">Questions Fréquentes</h3>
      </div>
      <div class="flex flex-col divide-y help-border">
        <div v-for="(faq, i) in faqs" :key="i">
          <button
            @click="open = open === i ? null : i"
            class="w-full flex items-center justify-between px-5 py-4 text-left transition-colors hover:bg-gray-50 dark:hover:bg-[var(--hover)]"
          >
            <span class="text-sm pr-4 faq-question">{{ faq.q }}</span>
            <ChevronDown
              class="w-4 h-4 flex-shrink-0 transition-transform"
              :style="{ color: 'var(--primary)', transform: open === i ? 'rotate(180deg)' : 'rotate(0deg)' }"
            />
          </button>

          <!-- ✅ Remplacé v-if par faq-body avec animation -->
          <div class="faq-body" :class="{ open: open === i }">
            <div class="faq-body-inner">
              <p class="px-5 pb-4 text-sm faq-answer">{{ faq.a }}</p>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { defineComponent, ref } from 'vue';
import { HelpCircle, MessageCircle, BookOpen, Phone, ChevronDown } from 'lucide-vue-next';

defineComponent({
  name: 'Aide'
});

const open = ref(null);

const contactItems = [
  { icon: MessageCircle, label: 'Support Chat', sub: 'Disponible 8h-18h', color: '#4F5CF5', bg: '#EEF2FF' },
  { icon: Phone, label: 'Téléphone', sub: '+213 34 81 68 19', color: '#16A34A', bg: '#DCFCE7' },
  { icon: BookOpen, label: 'Documentation', sub: 'Guide utilisateur', color: '#CA8A04', bg: '#FEF9C3' },
];

const faqs = [
  { q: 'Comment soumettre une réclamation ?', a: 'Rendez-vous dans la section "Réclamations", cliquez sur "Nouvelle" et remplissez le formulaire avec les détails de votre problème. Votre délégué sera automatiquement notifié.' },
  { q: "Quel est le délai de traitement d'une réclamation ?", a: "Le délai standard de traitement est de 5 à 7 jours ouvrables. Les réclamations urgentes peuvent être traitées sous 48h selon leur nature." },
  { q: "Comment suivre l'état de ma réclamation ?", a: 'Dans la section "Réclamations", vous pouvez filtrer par statut (En attente, Acceptée, Refusée) pour suivre l\'avancement de vos dossiers.' },
  { q: 'Qui peut soumettre un ticket ?', a: 'Les délégués et les professeurs peuvent soumettre des tickets liés à leurs cours respectifs. Les tickets apparaissent dans la section "Tickets".' },
  { q: 'Comment devenir délégué ?', a: "Les délégués sont désignés par l'administration après une élection au niveau de chaque promotion. Contactez votre responsable pédagogique pour plus d'informations." },
  { q: 'Comment voter pour une suggestion ?', a: 'Dans la section "Annonces", les suggestions soumises par les délégués affichent un bouton de vote. Cliquez dessus pour soutenir la proposition.' },
];
</script>

<style scoped>
.help-card {
  background: var(--card);
  box-shadow: 0 2px 12px var(--shadow-neutral-soft);
}

.help-title {
  color: var(--foreground);
  font-weight: 700;
}

.help-subtitle {
  color: var(--muted-foreground);
}

.help-border {
  border-color: var(--border);
}

.faq-question {
  color: var(--foreground);
  font-weight: 500;
}

.faq-answer {
  color: var(--muted-foreground);
  line-height: 1.7;
}

.faq-body {
  display: grid;
  grid-template-rows: 0fr;
  transition: grid-template-rows 0.35s cubic-bezier(0.4, 0, 0.2, 1);
}

.faq-body.open {
  grid-template-rows: 1fr;
}

.faq-body-inner {
  overflow: hidden;
}
</style>