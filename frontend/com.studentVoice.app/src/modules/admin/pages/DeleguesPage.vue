<template>
  <div class="flex flex-col gap-4">
    <!-- Stats Row -->
    <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-3">
      <!-- Stats Cards -->
      <div
        v-for="stat in stats"
        :key="stat.label"
        class="rounded-2xl p-4 flex items-center gap-3 cursor-pointer transition-all hover:shadow-md bg-white dark:bg-slate-800 border border-transparent dark:border-slate-700"
        style="box-shadow: 0 2px 12px rgba(0,0,0,0.06)"
      >
        <div class="w-9 h-9 rounded-xl flex items-center justify-center flex-shrink-0" :style="{ background: stat.bg }">
          <component :is="stat.icon" class="w-4 h-4" :style="{ color: stat.color }" />
        </div>
        <div>
          <p class="text-xl font-bold leading-none text-slate-800 dark:text-white">{{ stat.value }}</p>
          <p class="text-xs text-slate-400 dark:text-slate-500 mt-1">{{ stat.label }}</p>
        </div>
      </div>

    </div>
 
    <!-- Action Bar -->
    <div class="flex items-center justify-end">
      <button
        @click="showForm = !showForm"
        class="flex items-center gap-1.5 px-4 py-2.5 rounded-xl text-white text-sm transition-all hover:opacity-90 active:scale-95 shadow-lg shadow-blue-500/20"
        style="background: linear-gradient(135deg, var(--blue-dark) 0%, var(--blue) 50%, var(--blue-deep) 100%); --blue: #255fe3; --blue-dark: #1f54d2; --blue-deep: #1d3f95; font-weight: 600"
      >
        <Plus class="w-4 h-4" />
        Nouveau délégué
      </button>
    </div>

    <!-- Formulaire -->
      <div v-if="showForm" class="bg-white dark:bg-slate-800 p-6 rounded-3xl border border-blue-100 dark:border-blue-900 shadow-lg shadow-blue-500/5 animate-slide-down">
        <h3 class="text-lg font-semibold text-slate-800 dark:text-white mb-4">Désigner un délégué existant</h3>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
          <input v-model="searchQuery.nom" placeholder="Nom ou prénom" />
          <input v-model="searchQuery.email" placeholder="Email (optionnel)" />
        </div>
        <div class="flex gap-3 justify-end mt-2">
          <button @click="showForm = false" class="px-5 py-2.5 rounded-xl text-sm font-semibold text-slate-600 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-700 transition-colors">Annuler</button>
          <button @click="search" :disabled="searching" class="px-5 py-2.5 rounded-xl text-sm font-semibold text-white bg-blue-600 hover:bg-blue-700 shadow-md shadow-blue-500/20 active:scale-95 transition-all w-full sm:w-auto">
            {{ searching ? 'Recherche...' : 'Rechercher' }}
          </button>
        </div>

        <div v-if="searchResults.length > 0" class="mt-6 grid grid-cols-1 md:grid-cols-2 gap-4">
          <div v-for="u in searchResults" :key="u.id" class="p-4 rounded-2xl border bg-white dark:bg-slate-800 flex items-center justify-between">
            <div>
              <div class="font-semibold">{{ u.nom || u.prenom_utilisateurs + ' ' + u.nom_utilisateurs }}</div>
              <div class="text-sm text-slate-500">{{ u.email || u.email_utilisateurs }}</div>
              <div v-if="u.filiere" class="text-xs text-slate-400">{{ u.filiere }}</div>
            </div>
            <div class="flex items-center gap-2">
              <button @click="designateExisting(u)" class="px-3 py-1 rounded-md bg-emerald-600 text-white text-sm">Désigner</button>
            </div>
          </div>
        </div>

        <div v-else-if="searched" class="mt-6 text-sm text-slate-500">Aucun utilisateur correspondant trouvé.</div>
      </div>

    <!-- Cards Délégués -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mt-4">
      <div
        v-for="d in delegues"
        :key="d.id"
        class="group relative bg-white dark:bg-slate-800 rounded-3xl p-5 border transition-all duration-300 hover:shadow-xl hover:shadow-slate-200/50 dark:hover:shadow-black/50 flex flex-col h-full"
        :class="[
          d.actif ? 'border-slate-200 dark:border-slate-700 hover:border-blue-300 dark:hover:border-blue-600/50' : 'border-slate-100 dark:border-slate-800 opacity-75 grayscale-[0.2]'
        ]"
      >
        <!-- Status toggle -->
        <div class="absolute top-4 right-4">
           <button
             @click="toggle(d.id)"
             class="flex items-center gap-1.5 px-2.5 py-1 rounded-lg text-xs font-semibold transition-all active:scale-95 border"
             :class="[
               d.actif 
                 ? 'text-emerald-700 bg-emerald-50 border-emerald-200 dark:text-emerald-400 dark:bg-emerald-900/30 dark:border-emerald-800/50 hover:bg-emerald-100' 
                 : 'text-slate-500 bg-slate-50 border-slate-200 dark:text-slate-400 dark:bg-slate-800 dark:border-slate-700 hover:bg-slate-100'
             ]"
           >
             <span class="w-1.5 h-1.5 rounded-full" :class="d.actif ? 'bg-emerald-500 dark:bg-emerald-400' : 'bg-slate-400 dark:bg-slate-500'"></span>
             {{ d.actif ? 'Actif' : 'Inactif' }}
           </button>
        </div>

        <!-- Profil -->
        <div class="flex items-center gap-4 mb-5 mt-2">
          <div
            class="w-14 h-14 rounded-2xl flex items-center justify-center text-white font-bold text-xl shadow-inner"
            :style="{ background: `linear-gradient(135deg, ${filiereColors[d.filiere] || '#4F5CF5'}, ${filiereColors[d.filiere] ? filiereColors[d.filiere] + 'dd' : '#4F5CF5dd'})` }"
          >
            {{ d.nom.charAt(0) }}
          </div>
          <div>
            <h3 class="text-base font-bold text-slate-800 dark:text-white group-hover:text-blue-600 dark:group-hover:text-blue-400 transition-colors">{{ d.nom }}</h3>
            <div class="flex items-center gap-2 mt-1">
              <span v-if="d.filiere"
                class="text-[11px] px-2 py-0.5 rounded-md font-bold"
                :style="{ background: (filiereColors[d.filiere] || '#4F5CF5') + '15', color: filiereColors[d.filiere] || '#4F5CF5' }"
              >
                {{ d.filiere }}
              </span>
              <span class="text-xs font-semibold text-slate-400 dark:text-slate-500 bg-slate-100 dark:bg-slate-800/80 px-1.5 py-0.5 rounded">{{ d.annee }}</span>
              <span v-if="d.actif" class="text-[11px] px-2 py-0.5 rounded-md font-bold ml-1" :style="{background: '#FEF9C3', color: '#CA8A04'}">Délégué</span>
              <span v-else-if="d.role" class="text-[11px] px-2 py-0.5 rounded-md font-bold ml-1 text-slate-500">{{ d.role }}</span>
            </div>
          </div>
        </div>

        <!-- Contact info -->
        <div class="space-y-2.5 mb-6 flex-grow">
          <div v-if="d.email" class="flex items-center gap-2.5 text-sm text-slate-600 dark:text-slate-400">
            <div class="w-7 h-7 rounded-lg bg-slate-50 dark:bg-slate-900 flex items-center justify-center border border-slate-100 dark:border-slate-800">
              <Mail class="w-3.5 h-3.5" />
            </div>
            <span class="truncate">{{ d.email }}</span>
          </div>
          <div v-if="d.telephone" class="flex items-center gap-2.5 text-sm text-slate-600 dark:text-slate-400">
            <div class="w-7 h-7 rounded-lg bg-slate-50 dark:bg-slate-900 flex items-center justify-center border border-slate-100 dark:border-slate-800">
              <Phone class="w-3.5 h-3.5" />
            </div>
            <span>{{ d.telephone }}</span>
          </div>
        </div>

        <!-- Card Footer -->
        <div class="pt-4 border-t border-slate-100 dark:border-slate-700/50 flex items-center justify-between">
          <div class="flex gap-4">
             <div class="flex flex-col">
               <span class="text-[10px] text-slate-400 uppercase font-bold tracking-wider mb-0.5">Tickets</span>
               <div class="flex items-center gap-1.5 text-sm font-semibold text-slate-700 dark:text-slate-300">
                 <BookOpen class="w-3.5 h-3.5 text-blue-500" />
                 {{ d.reclamationsTraitees }}
               </div>
             </div>
             
             <div v-if="d.note > 0" class="flex flex-col">
               <span class="text-[10px] text-slate-400 uppercase font-bold tracking-wider mb-0.5">Éval</span>
               <div class="flex items-center gap-1.5 text-sm font-semibold text-slate-700 dark:text-slate-300">
                 <Star class="w-3.5 h-3.5 text-amber-500 fill-amber-500" />
                 {{ d.note }}
               </div>
             </div>
          </div>

          <button
            @click="remove(d.id)"
            class="w-8 h-8 rounded-xl flex items-center justify-center text-slate-400 hover:text-red-500 hover:bg-red-50 dark:hover:bg-red-500/10 transition-colors"
            title="Supprimer"
          >
            <Trash2 class="w-4 h-4" />
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, reactive, onMounted } from 'vue';
import { onBeforeRouteUpdate } from 'vue-router'
import { UserCheck, Plus, Trash2, Mail, Phone, BookOpen, Star, CheckCircle, FileText } from 'lucide-vue-next';
import CustomSelect from '../../../components/CustomSelect.vue'
import { listUsers, designateDelegate, createEtudiant } from '../../../composables/useAdmin'

const filieres = ['Informatique', 'Mathématiques', 'Sciences', 'Physique', 'Chimie'];

const filiereColors = {
  'Informatique': '#4F5CF5',
  'Mathématiques': '#8B5CF6',
  'Sciences': '#10B981',
  'Physique': '#F59E0B',
  'Chimie': '#EF4444',
};

const filiereOptions = filieres.map(f => ({
  value: f,
  label: f,
  dot: filiereColors[f] || '#4F5CF5',
}));

const delegues = ref([]);

function handleAuthError(err) {
  if (err && err.status === 401) {
    window.alert('Session expirée ou non autorisée. Veuillez vous reconnecter en tant qu\'admin.')
    window.location.href = '/home/login'
    return true
  }
  return false
}

// Load delegues from backend users list
async function loadDelegues(force = true) {
  try {
    const res = await listUsers(force)
    if (res && res.data) {
      // map utilisateurs to delegue card shape
      delegues.value = res.data
        .filter(u => {
          const roleRaw = (u.role && (u.role.nom_roles || u.role)) || ''
          const roleNormalized = roleRaw.toString().normalize('NFD').replace(/\p{Diacritic}/gu, '').toLowerCase()
          return u.actif === true || roleNormalized.includes('deleg')
        })
        .map(u => ({
          id: u.id,
          nom: u.nom || (u.prenom_utilisateurs && u.nom_utilisateurs ? `${u.prenom_utilisateurs} ${u.nom_utilisateurs}` : ''),
          filiere: u.filiere || '',
          annee: '',
          email: u.email || u.email_utilisateurs || '',
          telephone: u.telephone || '',
          reclamationsTraitees: u.reclamations || 0,
          note: u.note || 0,
          actif: u.actif || false,
          role: (u.role && (u.role.nom_roles || u.role)) || ''
        }))
    }
  } catch (err) {
    if (handleAuthError(err)) return
    console.error('Failed to load delegues', err)
  }
}

onMounted(() => loadDelegues(true))
onBeforeRouteUpdate((to, from) => {
  // refresh when the route updates and this component is reused
  loadDelegues(true)
})

const showForm = ref(false);
const form = reactive({ nom: '', filiere: '', annee: '', email: '', telephone: '', date_naissance: '' });
const searchQuery = reactive({ nom: '', email: '' })
const searchResults = ref([])
const searching = ref(false)
const searched = ref(false)

const stats = computed(() => {
  // Count delegates by either `actif` flag or role containing 'deleg'
  const delegatesCount = delegues.value.filter(d => {
    const r = (d.role || '').toString().normalize('NFD').replace(/\p{Diacritic}/gu, '').toLowerCase()
    return (d.actif === true) || r.includes('deleg')
  }).length
  return [
    { label: 'Délégués Actifs', value: delegatesCount, color: '#10B981', bg: 'rgba(16, 185, 129, 0.1)', icon: CheckCircle },
    { label: 'Total Réclamations Traitées', value: delegues.value.reduce((a, d) => a + d.reclamationsTraitees, 0), color: '#4F5CF5', bg: 'rgba(79, 92, 245, 0.1)', icon: FileText },
  ]
})

const toggle = async (id) => {
  const d = delegues.value.find(d => d.id === id);
  if (!d) return;
  const newStatus = !d.actif
  try {
    await designateDelegate(id, { delegue: newStatus })
    d.actif = newStatus
  } catch (err) {
    if (handleAuthError(err)) return
    console.error('Failed to update delegate status', err)
  }
};

const remove = async (id) => {
  if (confirm("Voulez-vous révoquer le statut de délégué de cet étudiant ? Il redeviendra un étudiant normal.")) {
    try {
      await designateDelegate(id, { delegue: false });
      delegues.value = delegues.value.filter(d => d.id !== id);
    } catch (e) {
      console.error('Erreur lors de la révocation du délégué', e);
      if (handleAuthError(e)) return;
      alert("Erreur lors de la révocation du statut de délégué.");
    }
  }
};

const add = async () => {
  if (!form.nom || !form.filiere) return;

  const parts = form.nom.trim().split(/\s+/);
  const prenom = parts.length > 1 ? parts.slice(0, -1).join(' ') : parts[0];
  const nom = parts.length > 1 ? parts[parts.length - 1] : parts[0];

  const account = {
    email_utilisateurs: form.email || `no-reply+${Date.now()}@univ-bejaia.dz`,
    password: 'ChangeMe123!',
    prenom_utilisateurs: prenom || form.nom,
    nom_utilisateurs: nom || form.nom,
    role: 'etudiant',
    groupe: form.filiere,
    date_naissance_etudiant: form.date_naissance || new Date().toISOString().slice(0, 10),
    telephone_etudiant: form.telephone || '',
    est_delegue_etudiant: true,
  }

  try {
    await createEtudiant(account)
    await loadDelegues(true)
    form.nom = '';
    form.filiere = '';
    form.annee = '';
    form.email = '';
    form.telephone = '';
    form.date_naissance = '';
    showForm.value = false;
  } catch (err) {
    if (handleAuthError(err)) return
    console.error('Failed to create etudiant', err)
  }
}

// Search existing users by name and/or email and show results
const search = async () => {
  searching.value = true
  searched.value = false
  searchResults.value = []
  try {
    const res = await listUsers(true)
    const arr = (res && res.data) ? res.data : []
    console.debug('[DeleguesPage] listUsers response ->', arr)

    const qNom = (searchQuery.nom || '').toLowerCase().trim()
    const qEmail = (searchQuery.email || '').toLowerCase().trim()

    const filtered = arr.filter(u => {
      const fullname = ((u.nom || '') + ' ' + (u.prenom_utilisateurs || '')).toLowerCase()
      const email = (u.email || u.email_utilisateurs || '').toLowerCase()
      const matchesNom = qNom ? fullname.includes(qNom) || (u.prenom_utilisateurs || '').toLowerCase().includes(qNom) : true
      const matchesEmail = qEmail ? email.includes(qEmail) : true
      return matchesNom && matchesEmail
    })

    searchResults.value = filtered
    searched.value = true
    console.debug('[DeleguesPage] search results ->', filtered)
  } catch (err) {
    if (handleAuthError(err)) return
    console.error('Search failed', err)
  } finally {
    searching.value = false
  }
}

const designateExisting = async (user) => {
  try {
    // Use utilisateur id (backend DelegationController accepts utilisateur id)
    console.debug('[designateExisting] calling designateDelegate with id, payload ->', user.id, { delegue: true })
    const res = await designateDelegate(user.id, { delegue: true })
    console.debug('[designateExisting] response ->', res)

    // Optimistic UI update: mark the user as actif in local delegues mapping
    const local = delegues.value.find(d => d.id === user.id)
    if (local) local.actif = true
    // Basic feedback for debugging / UX
    if (res && (res.data || res.status === 'ok' || res.message)) {
      window.alert('Désignation effectuée')
    } else {
      window.alert('Désignation envoyée — vérifier la console pour la réponse')
    }
    await loadDelegues(true)
    // Additional debug: fetch raw users list from API and log the specific utilisateur
    try {
      const raw = await listUsers(true)
      console.debug('[designateExisting] raw users API response ->', raw)
      const found = (raw && raw.data) ? raw.data.find(u => u.id === user.id) : null
      console.debug('[designateExisting] utilisateur after update ->', found)
      console.debug('[designateExisting] delegues local mapping ->', delegues.value)
    } catch (e) {
      console.error('[designateExisting] failed to reload raw users', e)
    }

    showForm.value = false
    searchResults.value = []
    searchQuery.nom = ''
    searchQuery.email = ''
  } catch (err) {
    console.error('[designateExisting] error details:', err)
    console.error('[designateExisting] error status:', err?.status)
    console.error('[designateExisting] error response:', err?.response)
    if (handleAuthError(err)) return
    const errorMsg = err?.message || (err?.response ? JSON.stringify(err.response) : JSON.stringify(err))
    window.alert('Erreur lors de la désignation : ' + errorMsg)
  }
}
</script>
