<template>
  <div class="flex flex-col gap-4">
    <!-- Summary Chips -->
    <div class="flex gap-2 flex-wrap">
      <button
        v-for="chip in chips"
        :key="chip.label"
        @click="filter = chip.filter"
        class="inline-flex items-center gap-1.5 px-2.5 py-1.5 sm:px-4 sm:py-2 rounded-xl transition-all text-xs sm:text-sm"
        :style="{
          background: filter === chip.filter ? chip.gradient : chip.bg,
          color: filter === chip.filter ? '#fff' : chip.color,
          fontWeight: 600,
          boxShadow: filter === chip.filter ? chip.shadow : 'none',
        }"
      >
        <span style="font-weight: 700">{{ chip.value }}</span>
        <span class="hidden sm:inline">{{ chip.label }}</span>
      </button>
    </div>

    <!-- Table Card -->
    <div class="rounded-2xl overflow-hidden bg-white dark:bg-slate-800 shadow-sm border border-gray-100 dark:border-slate-700">
      <div class="flex items-center justify-between px-4 py-3 sm:px-5 sm:py-4 border-b border-gray-100 dark:border-slate-700">
        <h3 class="text-sm sm:text-base font-bold text-gray-900 dark:text-white">
          Tikets soumis par les étudiants
        </h3>
      </div>

      <div class="space-y-2 sm:space-y-3 p-3 sm:p-4">
        <div
          v-for="(r, i) in filtered"
          :key="r.id"
          class="rounded-xl sm:rounded-2xl border border-gray-200 dark:border-slate-700 bg-white dark:bg-slate-900/50 p-3 sm:p-4 transition-colors hover:bg-gray-50 dark:hover:bg-slate-800"
        >
          <div class="mb-2 sm:mb-3 flex flex-col justify-between gap-2 sm:flex-row sm:items-start">
            <div class="min-w-0 flex-1">
              <p class="text-xs text-gray-500 dark:text-gray-400">{{ r.date }} • {{ r.id }}</p>
              <h3 class="text-xs sm:text-sm font-semibold text-gray-900 dark:text-white line-clamp-2">{{ r.objet }}</h3>
            </div>
            <span
              class="text-xs px-2 py-1 sm:px-2.5 sm:py-1 rounded-full flex-shrink-0"
              :style="{ background: (statusConfig[r.status] && statusConfig[r.status].bg) || '#E6E7E9', color: (statusConfig[r.status] && statusConfig[r.status].color) || '#374151', fontWeight: 600 }"
            >
              {{ r.status || 'Inconnu' }}
            </span>
          </div>
          <div class="grid grid-cols-2 gap-2 text-xs sm:text-sm sm:grid-cols-3 lg:grid-cols-4 mb-2 sm:mb-3">
            <div class="flex items-center gap-1.5 sm:gap-2">
              <div
                class="w-5 h-5 sm:w-6 sm:h-6 rounded-full flex items-center justify-center text-white text-xs flex-shrink-0"
                :style="{ background: avatarColors[i % 4], fontWeight: 700 }"
              >
                {{ r.etudiant.charAt(0) }}
              </div>
              <div class="min-w-0">
                <p class="text-xs text-gray-500 dark:text-gray-400">Étudiant</p>
                <p class="text-xs sm:text-sm font-medium text-gray-900 dark:text-gray-100 truncate">{{ r.etudiant }}</p>
              </div>
            </div>
            <div>
              <p class="text-xs text-gray-500 dark:text-gray-400">Filière</p>
              <p class="text-xs sm:text-sm font-medium text-gray-900 dark:text-gray-100 truncate">{{ r.filiere }}</p>
            </div>
            <div>
              <p class="text-xs text-gray-500 dark:text-gray-400">Délégué</p>
              <p class="text-xs sm:text-sm font-medium text-gray-900 dark:text-gray-100 truncate">{{ r.delegue }}</p>
            </div>
          </div>
          <div class="flex flex-wrap gap-1.5 sm:gap-2">
            <button
              @click="openDetail(r)"
              class="rounded-lg bg-blue-50 dark:bg-blue-900/30 px-2 py-1 sm:px-2.5 sm:py-1.5 text-xs font-semibold text-blue-700 dark:text-blue-400 transition-colors hover:bg-blue-100 dark:hover:bg-blue-900/50"
            >Voir d.</button>
            <button
              v-if="r.status === 'En attente'"
              @click="handleAction(r.id, 'Acceptée')"
              class="rounded-lg bg-emerald-50 dark:bg-emerald-900/30 px-2 py-1 sm:px-2.5 sm:py-1.5 text-xs font-semibold text-emerald-700 dark:text-emerald-400 transition-colors hover:bg-emerald-100 dark:hover:bg-emerald-900/50"
            >✓</button>
            <button
              v-if="r.status === 'En attente'"
              @click="openDetail(r)"
              class="rounded-lg bg-red-50 dark:bg-red-900/30 px-2 py-1 sm:px-2.5 sm:py-1.5 text-xs font-semibold text-red-700 dark:text-red-400 transition-colors hover:bg-red-100 dark:hover:bg-red-900/50"
            >✗</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Detail Modal -->
    <div
      v-if="showModal && selected"
      class="fixed inset-0 z-50 flex items-center justify-center p-3 sm:p-4"
      style="background: rgba(0,0,0,0.4)"
      @click="showModal = false; selected = null"
    >
      <div
        class="rounded-2xl p-4 sm:p-6 w-full max-w-md relative bg-white dark:bg-slate-800 shadow-2xl border border-gray-100 dark:border-slate-700"
        @click.stop
      >
        <div class="flex items-start justify-between mb-4">
          <div>
            <p class="text-xs mb-1 text-gray-400 dark:text-gray-500">{{ selected.id }}</p>
            <h3 class="text-base font-bold text-gray-900 dark:text-white">{{ selected.objet }}</h3>
          </div>
          <span
            class="text-xs px-2 py-1 rounded-full"
            :style="{
              background: (statusConfig[selected.status] && statusConfig[selected.status].bg) || '#E6E7E9',
              color: (statusConfig[selected.status] && statusConfig[selected.status].color) || '#374151',
              fontWeight: 600,
            }"
          >
            {{ selected.status || 'Inconnu' }}
          </span>
        </div>

        <div class="flex flex-col gap-2 mb-4 text-xs sm:text-sm">
          <div class="flex justify-between">
            <span class="text-gray-400 dark:text-gray-500">Étudiant</span>
            <span class="truncate ml-2 text-right font-medium text-gray-900 dark:text-white">{{ selected.etudiant }}</span>
          </div>
          <div class="flex justify-between">
            <span class="text-gray-400 dark:text-gray-500">Filière</span>
            <span class="truncate ml-2 text-right font-medium text-gray-900 dark:text-white">{{ selected.filiere }}</span>
          </div>
          <div class="flex justify-between">
            <span class="text-gray-400 dark:text-gray-500">Délégué</span>
            <span class="truncate ml-2 text-right font-medium text-gray-900 dark:text-white">{{ selected.delegue }}</span>
          </div>
          <div class="flex justify-between">
            <span class="text-gray-400 dark:text-gray-500">Date</span>
            <span class="truncate ml-2 text-right font-medium text-gray-900 dark:text-white">{{ selected.date }}</span>
          </div>
        </div>

        <div
          class="rounded-xl p-2 sm:p-3 mb-4 text-xs sm:text-sm bg-gray-50 dark:bg-slate-900 text-gray-600 dark:text-gray-300 border border-gray-100 dark:border-slate-700"
          style="line-height: 1.6"
        >
          {{ selected.description }}
        </div>

        <template v-if="selected.status === 'En attente'">
          <div class="mb-4">
            <label class="block text-xs sm:text-sm font-medium mb-2 text-gray-900 dark:text-white">Motif de décision (optionnel)</label>
            <textarea
              v-model="motif"
              placeholder="Expliquez brièvement la raison de votre décision..."
              class="w-full rounded-xl p-2 sm:p-3 text-xs sm:text-sm outline-none resize-none border border-gray-200 dark:border-slate-700 bg-white dark:bg-slate-900 text-gray-900 dark:text-white focus:ring-2 focus:ring-blue-500/20"
              style="min-height: 80px"
            />
          </div>
          <div class="flex flex-col sm:flex-row gap-2 sm:gap-3">
            <button
              @click="handleAction(selected.id, 'Acceptée')"
              class="flex-1 py-2 sm:py-2.5 rounded-xl text-white text-xs sm:text-sm transition-all hover:opacity-90 active:scale-95"
              style="background: linear-gradient(135deg, #128c3e 0%, #16A34A 50%, #0f7a35 100%); font-weight: 600; box-shadow: 0 2px 8px rgba(22,163,74,0.35)"
            >
              ✓ Accepter
            </button>
            <button
              @click="handleAction(selected.id, 'Refusée')"
              class="flex-1 py-2 sm:py-2.5 rounded-xl text-white text-xs sm:text-sm transition-all hover:opacity-90 active:scale-95"
              style="background: linear-gradient(135deg, #c41e1e 0%, #DC2626 50%, #a51b1b 100%); font-weight: 600; box-shadow: 0 2px 8px rgba(220,38,38,0.35)"
            >
              ✗ Refuser
            </button>
          </div>
        </template>

        <button
          v-if="selected.status !== 'En attente'"
          @click="showModal = false; selected = null"
          class="w-full py-2 sm:py-2.5 rounded-xl text-xs sm:text-sm font-semibold bg-indigo-50 dark:bg-indigo-900/30 text-indigo-600 dark:text-indigo-400 hover:bg-indigo-100 dark:hover:bg-indigo-900/50 transition-colors"
        >
          Fermer
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { CheckCircle, XCircle, Clock } from 'lucide-vue-next';
import { listTickets } from '../../../composables/useTickets'
import { decideTicket } from '../../../composables/useAdmin'

const avatarColors = ['#4F5CF5', '#818CF8', '#10B981', '#F59E0B'];

const statusConfig = {
  'En attente': { bg: '#FEF9C3', color: '#CA8A04', icon: Clock },
  'Acceptée': { bg: '#DCFCE7', color: '#16A34A', icon: CheckCircle },
  'Refusée': { bg: '#FEE2E2', color: '#DC2626', icon: XCircle },
};

const reclamations = ref([]);

// Load tickets from backend
onMounted(async () => {
  try {
    const res = await listTickets()
    if (res && res.data) {
      reclamations.value = res.data.map(t => ({
        id: t.id,
        etudiant: (t.utilisateur && (t.utilisateur.nom || t.utilisateur.email)) || t.etudiant_nom || 'Étudiant',
        filiere: t.filiere || t.filiere_ticket || '',
        objet: t.object_ticket || t.object || t.objet || '',
        date: t.cree_le_ticket || t.inserted_at || '',
        status: formatStatus(t.statut_ticket || t.status || 'en_attente'),
        description: t.description_ticket || t.description || '',
        delegue: t.delegue || '',
      }))
    }
  } catch (err) {
    console.error('Failed to load admin tickets', err)
  }
})

const filter = ref('Toutes');
const selected = ref(null);
const showModal = ref(false);
const motif = ref('');

const filtered = computed(() =>
  filter.value === 'Toutes' ? reclamations.value : reclamations.value.filter(r => r.status === filter.value)
);

const chips = computed(() => [
  { label: 'Total', value: reclamations.value.length, color: '#255fe3', bg: '#DEE2F0', gradient: 'linear-gradient(135deg, #1f54d2 0%, #255fe3 50%, #1d3f95 100%)', shadow: '0 2px 8px rgba(37,95,227,0.35)', filter: 'Toutes' },
  { label: 'En attente', value: reclamations.value.filter(r => r.status === 'En attente').length, color: '#CA8A04', bg: '#FEF9C3', gradient: 'linear-gradient(135deg, #b47d04 0%, #CA8A04 50%, #a16e03 100%)', shadow: '0 2px 8px rgba(202,138,4,0.35)', filter: 'En attente' },
  { label: 'Acceptées', value: reclamations.value.filter(r => r.status === 'Acceptée').length, color: '#16A34A', bg: '#DCFCE7', gradient: 'linear-gradient(135deg, #128c3e 0%, #16A34A 50%, #0f7a35 100%)', shadow: '0 2px 8px rgba(22,163,74,0.35)', filter: 'Acceptée' },
  { label: 'Refusées', value: reclamations.value.filter(r => r.status === 'Refusée').length, color: '#DC2626', bg: '#FEE2E2', gradient: 'linear-gradient(135deg, #c41e1e 0%, #DC2626 50%, #a51b1b 100%)', shadow: '0 2px 8px rgba(220,38,38,0.35)', filter: 'Refusée' },
]);

const handleAction = async (id, action) => {
  const r = reclamations.value.find(r => r.id === id);
  const actionKey = (action === 'Acceptée') ? 'accepter' : (action === 'Refusée') ? 'refuser' : null
  if (!actionKey) return

  // Optimistic UI
  if (r) r.status = action

  try {
    // call admin decide endpoint to ensure backend normalizes status and sends notifications
    await decideTicket(id, { decision: { action: actionKey, motif: motif.value || '' } })
    // reload list to get authoritative statuses
    const res = await listTickets(true)
    if (res && res.data) {
      reclamations.value = res.data.map(t => ({
        id: t.id,
        etudiant: (t.utilisateur && (t.utilisateur.nom || t.utilisateur.email)) || t.etudiant_nom || 'Étudiant',
        filiere: t.filiere || t.filiere_ticket || '',
        objet: t.object_ticket || t.object || t.objet || '',
        date: t.cree_le_ticket || t.inserted_at || '',
        status: formatStatus(t.statut_ticket || t.status || 'en_attente'),
        description: t.description_ticket || t.description || '',
        delegue: t.delegue || '',
      }))
    }
  } catch (err) {
    console.error('Failed to update ticket status', err)
  }

  showModal.value = false;
  motif.value = '';
  selected.value = null;
};

function formatStatus(raw) {
  if (!raw) return 'En attente'
  const s = raw.toString().toLowerCase()
  if (s.includes('en_attente') || s.includes('en attente') || s === 'en_attente' || s === 'en attente') return 'En attente'
  if (s.includes('accep') || s.includes('acceptee') || s.includes('accep té')) return 'Acceptée'
  if (s.includes('refus') || s.includes('refusee')) return 'Refusée'
  // fallback: replace underscores and capitalize
  const human = raw.toString().replace(/_/g, ' ')
  return human.charAt(0).toUpperCase() + human.slice(1)
}

const openDetail = (r) => {
  selected.value = r;
  showModal.value = true;
  motif.value = '';
};
</script>
