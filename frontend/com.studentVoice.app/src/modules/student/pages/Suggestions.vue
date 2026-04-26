<template>
  <div class="space-y-6">
    <!-- Page Header -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
      <div>
        <h1 class="text-2xl font-bold" :style="{ color: 'var(--foreground)' }">Suggestions</h1>
        <p class="text-sm mt-1" :style="{ color: 'var(--muted-foreground)' }">Améliorez notre communauté universitaire</p>
      </div>
      <button
        @click="showForm = !showForm"
        class="flex items-center gap-2 px-5 py-2.5 rounded-xl text-white text-sm font-semibold transition-all hover:opacity-90 active:scale-95 shadow-lg"
        style="background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 50%, #a855f7 100%)"
      >
        <Plus class="w-4 h-4" />
        Nouvelle suggestion
      </button>
    </div>

    <!-- Toast notification -->
    <Transition name="toast">
      <div
        v-if="toast.show"
        class="fixed top-6 right-6 z-50 flex items-center gap-3 px-5 py-3 rounded-xl shadow-2xl text-sm font-medium"
        :style="{
          background: toast.type === 'success' ? 'linear-gradient(135deg, #10b981, #059669)' : 'linear-gradient(135deg, #ef4444, #dc2626)',
          color: '#fff'
        }"
      >
        <CheckCircle v-if="toast.type === 'success'" class="w-5 h-5" />
        <AlertCircle v-else class="w-5 h-5" />
        <span>{{ toast.message }}</span>
      </div>
    </Transition>

    <!-- Info Banner -->
    <div class="rounded-xl p-4 border" :style="{ background: 'rgba(168, 85, 247, 0.05)', borderColor: 'rgba(168, 85, 247, 0.2)' }">
      <div class="flex items-start gap-3">
        <Lightbulb class="w-5 h-5 flex-shrink-0" style="color: #a855f7" />
        <div>
          <h3 class="font-semibold text-sm" :style="{ color: 'var(--foreground)' }">Comment ça marche ?</h3>
          <p class="text-xs mt-1" :style="{ color: 'var(--muted-foreground)' }">
            Proposez vos idées pour améliorer la vie universitaire. Les suggestions les plus votées seront examinées par l'administration.
          </p>
        </div>
      </div>
    </div>

    <!-- Formulaire d'ajout -->
    <Transition name="slide-fade">
      <div v-if="showForm" class="rounded-xl p-6 border" :style="{ background: 'var(--card)', borderColor: 'rgba(99, 102, 241, 0.25)', boxShadow: '0 4px 24px rgba(99, 102, 241, 0.08)' }">
        <h3 class="text-base font-bold mb-5 flex items-center gap-2" :style="{ color: 'var(--foreground)' }">
          <Sparkles class="w-5 h-5" style="color: #8b5cf6" />
          Nouvelle Suggestion
        </h3>
        <div class="grid grid-cols-1 gap-4 mb-5 sm:grid-cols-2">
          <input 
            v-model="formData.title" 
            placeholder="Titre de la suggestion*" 
            class="col-span-1 sm:col-span-2 px-4 py-2.5 rounded-xl border text-sm transition-all focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-400"
            :style="{ background: 'var(--surface-card)', borderColor: 'rgba(99, 102, 241, 0.2)', color: 'var(--foreground)' }"
          />
          <!-- Author (auto-filled, read-only) -->
          <div class="relative">
            <User class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4" style="color: #a855f7" />
            <input 
              :value="userName"
              disabled
              class="w-full pl-9 pr-3 py-2.5 rounded-xl border text-sm cursor-not-allowed opacity-70"
              :style="{ background: 'var(--surface-card)', borderColor: 'rgba(99, 102, 241, 0.15)', color: 'var(--foreground)' }"
            />
          </div>
          <CustomSelect
            v-model="formData.category"
            :options="categoryOptions"
            placeholder="Sélectionner une catégorie*"
          />
          <textarea 
            v-model="formData.description" 
            placeholder="Décrivez votre suggestion en détail...*" 
            rows="4" 
            class="col-span-1 sm:col-span-2 px-4 py-2.5 rounded-xl border text-sm resize-none transition-all focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-400"
            :style="{ background: 'var(--surface-card)', borderColor: 'rgba(99, 102, 241, 0.2)', color: 'var(--foreground)' }"
          ></textarea>
        </div>
        <div class="flex gap-3 justify-end">
          <button 
            @click="showForm = false" 
            class="px-5 py-2.5 rounded-xl text-sm font-medium transition-all hover:opacity-80"
            :style="{ background: 'rgba(99, 102, 241, 0.08)', color: '#6366f1' }"
          >
            Annuler
          </button>
          <button 
            @click="addSuggestion" 
            :disabled="submitting || !formValid"
            class="px-5 py-2.5 rounded-xl text-white text-sm font-semibold transition-all hover:opacity-90 active:scale-95 disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-2"
            style="background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 50%, #a855f7 100%)"
          >
            <Loader2 v-if="submitting" class="w-4 h-4 animate-spin" />
            <Send v-else class="w-4 h-4" />
            {{ submitting ? 'Publication...' : 'Publier' }}
          </button>
        </div>
      </div>
    </Transition>

    <!-- Search & Filters -->
    <div class="flex flex-col gap-3 sm:flex-row sm:items-center">
      <div class="relative flex-1">
        <Search class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4" :style="{ color: 'var(--muted-foreground)' }" />
        <input
          v-model="searchQuery"
          type="text"
          placeholder="Rechercher une suggestion..."
          class="w-full pl-10 pr-4 py-2.5 rounded-xl border text-sm transition-all focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-400"
          :style="{ background: 'var(--surface-card)', borderColor: 'rgba(99, 102, 241, 0.15)', color: 'var(--foreground)' }"
        />
      </div>
    </div>

    <!-- Category Filter Chips -->
    <div class="flex flex-wrap gap-2">
      <button
        @click="activeFilter = 'all'"
        class="px-3.5 py-1.5 rounded-full text-xs font-medium transition-all"
        :style="{
          background: activeFilter === 'all' ? '#6366f1' : 'rgba(99, 102, 241, 0.08)',
          color: activeFilter === 'all' ? '#fff' : '#6366f1'
        }"
      >
        Toutes
      </button>
      <button
        v-for="cat in categoryOptions"
        :key="cat.value"
        @click="activeFilter = cat.value"
        class="px-3.5 py-1.5 rounded-full text-xs font-medium transition-all flex items-center gap-1.5"
        :style="{
          background: activeFilter === cat.value ? cat.dot : `${cat.dot}15`,
          color: activeFilter === cat.value ? '#fff' : cat.dot
        }"
      >
        <span class="w-2 h-2 rounded-full" :style="{ background: activeFilter === cat.value ? '#fff' : cat.dot }"></span>
        {{ cat.label }}
      </button>
      <button
        @click="activeFilter = activeFilter === 'mine' ? 'all' : 'mine'"
        class="px-3.5 py-1.5 rounded-full text-xs font-medium transition-all flex items-center gap-1.5 ml-auto"
        :style="{
          background: activeFilter === 'mine' ? '#f59e0b' : 'rgba(245, 158, 11, 0.08)',
          color: activeFilter === 'mine' ? '#fff' : '#f59e0b'
        }"
      >
        <UserCheck class="w-3.5 h-3.5" />
        Mes suggestions
      </button>
    </div>

    <!-- Stats Section -->
    <div class="rounded-xl p-5 border" :style="{ background: 'var(--card)', borderColor: 'rgba(99, 102, 241, 0.15)' }">
      <h2 class="text-sm font-bold mb-4 flex items-center gap-2" :style="{ color: 'var(--foreground)' }">
        <BarChart3 class="w-4 h-4" style="color: #6366f1" />
        Statistiques
      </h2>
      <div class="grid grid-cols-3 gap-4">
        <div class="text-center p-3 rounded-xl" :style="{ background: 'rgba(99, 102, 241, 0.06)' }">
          <p class="text-2xl font-bold" style="color: #6366f1">{{ suggestions.length }}</p>
          <p class="text-xs mt-1" :style="{ color: 'var(--muted-foreground)' }">Suggestions</p>
        </div>
        <div class="text-center p-3 rounded-xl" :style="{ background: 'rgba(168, 85, 247, 0.06)' }">
          <p class="text-2xl font-bold" style="color: #a855f7">{{ totalVotes }}</p>
          <p class="text-xs mt-1" :style="{ color: 'var(--muted-foreground)' }">Votes totaux</p>
        </div>
        <div class="text-center p-3 rounded-xl" :style="{ background: 'rgba(16, 185, 129, 0.06)' }">
          <p class="text-2xl font-bold" style="color: #10b981">{{ myVotesCount }}</p>
          <p class="text-xs mt-1" :style="{ color: 'var(--muted-foreground)' }">Mes votes</p>
        </div>
      </div>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="flex flex-col gap-3">
      <div v-for="n in 3" :key="n" class="rounded-xl p-5 border animate-pulse" :style="{ background: 'var(--card)', borderColor: 'rgba(99, 102, 241, 0.1)' }">
        <div class="flex items-start justify-between">
          <div class="flex-1 space-y-3">
            <div class="h-4 w-20 rounded-full" :style="{ background: 'rgba(99, 102, 241, 0.1)' }"></div>
            <div class="h-5 w-3/4 rounded" :style="{ background: 'rgba(99, 102, 241, 0.08)' }"></div>
            <div class="h-3 w-full rounded" :style="{ background: 'rgba(99, 102, 241, 0.05)' }"></div>
            <div class="h-3 w-2/3 rounded" :style="{ background: 'rgba(99, 102, 241, 0.05)' }"></div>
          </div>
          <div class="w-12 h-16 rounded-xl ml-4" :style="{ background: 'rgba(99, 102, 241, 0.08)' }"></div>
        </div>
      </div>
    </div>

    <!-- Empty State -->
    <div v-else-if="filteredSuggestions.length === 0" class="text-center py-16 rounded-xl border" :style="{ background: 'var(--card)', borderColor: 'rgba(99, 102, 241, 0.1)' }">
      <div class="w-16 h-16 mx-auto mb-4 rounded-full flex items-center justify-center" :style="{ background: 'rgba(168, 85, 247, 0.08)' }">
        <Lightbulb class="w-8 h-8" style="color: #a855f7; opacity: 0.5" />
      </div>
      <p class="text-sm font-medium mb-1" :style="{ color: 'var(--foreground)' }">
        {{ suggestions.length === 0 ? 'Aucune suggestion pour le moment' : 'Aucun résultat trouvé' }}
      </p>
      <p class="text-xs" :style="{ color: 'var(--muted-foreground)' }">
        {{ suggestions.length === 0 ? 'Soyez le premier à en proposer une !' : 'Essayez de modifier vos filtres ou votre recherche.' }}
      </p>
    </div>

    <!-- Suggestions List -->
    <TransitionGroup v-else name="list" tag="div" class="flex flex-col gap-3">
      <div
        v-for="suggestion in filteredSuggestions"
        :key="suggestion.id"
        class="rounded-xl p-5 border transition-all hover:shadow-lg group"
        :style="{ background: 'var(--card)', borderColor: 'rgba(99, 102, 241, 0.15)' }"
      >
        <div class="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
          <div class="flex-1 min-w-0">
            <div class="flex items-center gap-2 mb-3 flex-wrap">
              <span
                class="text-xs px-2.5 py-1 rounded-full font-medium"
                :style="{ background: getCategoryColor(suggestion.category) + '18', color: getCategoryColor(suggestion.category) }"
              >
                {{ suggestion.category }}
              </span>
              <span class="text-xs px-2 py-0.5 rounded-full" :style="{ background: 'rgba(99, 102, 241, 0.06)', color: 'var(--muted-foreground)' }">
                #{{ suggestion.id }}
              </span>
            </div>
            <h3 class="text-base font-bold mb-2" :style="{ color: 'var(--foreground)' }">
              {{ suggestion.title }}
            </h3>
            <p class="text-sm leading-relaxed mb-4" :style="{ color: 'var(--muted-foreground)' }">
              {{ suggestion.description }}
            </p>
            <div class="flex flex-wrap items-center gap-4 text-xs" :style="{ color: 'var(--muted-foreground)' }">
              <div class="flex items-center gap-1.5">
                <User class="w-3.5 h-3.5 flex-shrink-0" />
                <span class="font-medium">{{ suggestion.author }}</span>
              </div>
              <div class="flex items-center gap-1.5">
                <Clock class="w-3.5 h-3.5 flex-shrink-0" />
                <span>{{ formatRelativeDate(suggestion.date) }}</span>
              </div>
            </div>
          </div>
          <!-- Vote buttons -->
          <div class="flex items-center gap-2 flex-shrink-0">
            <button
              @click="handleVote(suggestion.id, 'like')"
              :disabled="votingId === suggestion.id"
              class="flex flex-col items-center gap-1 px-3 py-2.5 rounded-xl transition-all font-medium text-xs border hover:shadow-md active:scale-95 disabled:opacity-50"
              :style="{
                background: suggestion.userVote === 'like' ? 'linear-gradient(135deg, #6366f1, #8b5cf6)' : 'rgba(99, 102, 241, 0.06)',
                color: suggestion.userVote === 'like' ? '#FFFFFF' : '#6366f1',
                borderColor: suggestion.userVote === 'like' ? 'transparent' : 'rgba(99, 102, 241, 0.2)',
              }"
            >
              <ThumbsUp class="w-4 h-4 transition-transform" :class="{ 'scale-110': suggestion.userVote === 'like' }" />
              <span class="text-sm font-bold">{{ suggestion.likes }}</span>
            </button>
            <button
              @click="handleVote(suggestion.id, 'dislike')"
              :disabled="votingId === suggestion.id"
              class="flex flex-col items-center gap-1 px-3 py-2.5 rounded-xl transition-all font-medium text-xs border hover:shadow-md active:scale-95 disabled:opacity-50"
              :style="{
                background: suggestion.userVote === 'dislike' ? 'linear-gradient(135deg, #ef4444, #dc2626)' : 'rgba(239, 68, 68, 0.06)',
                color: suggestion.userVote === 'dislike' ? '#FFFFFF' : '#ef4444',
                borderColor: suggestion.userVote === 'dislike' ? 'transparent' : 'rgba(239, 68, 68, 0.2)',
              }"
            >
              <ThumbsDown class="w-4 h-4 transition-transform" :class="{ 'scale-110': suggestion.userVote === 'dislike' }" />
              <span class="text-sm font-bold">{{ suggestion.dislikes }}</span>
            </button>
          </div>
        </div>
      </div>
    </TransitionGroup>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { Lightbulb, ThumbsUp, ThumbsDown, Plus, User, Clock, Search, Send, Loader2, Sparkles, CheckCircle, AlertCircle, UserCheck, BarChart3 } from 'lucide-vue-next'
import CustomSelect from '../../../components/CustomSelect.vue'
import { getSuggestions, createSuggestion, voteSuggestion } from '../../../composables/useSuggestions'
import { useAuth } from '../../../composables/useAuth'

const { user } = useAuth()

const showForm = ref(false)
const loading = ref(true)
const submitting = ref(false)
const votingId = ref(null)
const searchQuery = ref('')
const activeFilter = ref('all')

// Toast
const toast = ref({ show: false, message: '', type: 'success' })
function showToast(message, type = 'success') {
  toast.value = { show: true, message, type }
  setTimeout(() => { toast.value.show = false }, 3000)
}

// User name from auth — auto-filled, not editable
const userName = computed(() => {
  if (user.value && user.value.name) return user.value.name
  return 'Étudiant'
})

const categoryOptions = ref([
  { value: 'Innovation', label: 'Innovation', dot: '#6366f1' },
  { value: 'Infrastructure', label: 'Infrastructure', dot: '#f59e0b' },
  { value: 'Formation', label: 'Formation', dot: '#10b981' },
  { value: 'Vie étudiante', label: 'Vie étudiante', dot: '#ec4899' },
  { value: 'Services', label: 'Services', dot: '#8b5cf6' },
  { value: 'Général', label: 'Général', dot: '#64748b' },
])

const formData = ref({
  title: '',
  description: '',
  category: ''
})

const formValid = computed(() => {
  return formData.value.title.trim() && formData.value.description.trim() && formData.value.category
})

const suggestions = ref([])

function getCategoryColor(category) {
  const cat = categoryOptions.value.find(c => c.value === category || c.label === category)
  return cat ? cat.dot : '#6366f1'
}

function formatRelativeDate(dateString) {
  if (!dateString) return ''
  const d = new Date(dateString)
  const now = new Date()
  const diffSeconds = Math.floor((now - d) / 1000)

  if (diffSeconds < 60) return "À l'instant"
  const diffMinutes = Math.floor(diffSeconds / 60)
  if (diffMinutes < 60) return `Il y a ${diffMinutes} min`
  const diffHours = Math.floor(diffMinutes / 60)
  if (diffHours < 24) return `Il y a ${diffHours}h`
  const diffDays = Math.floor(diffHours / 24)
  if (diffDays < 7) return `Il y a ${diffDays}j`
  if (diffDays < 30) return `Il y a ${Math.floor(diffDays / 7)} sem.`
  return d.toLocaleDateString('fr-FR', { day: 'numeric', month: 'short', year: 'numeric' })
}

onMounted(async () => {
  try {
    const res = await getSuggestions()
    if (res && res.data) {
      suggestions.value = res.data.map(s => ({
        id: s.id,
        title: s.titre_souggestion,
        description: s.contenu_souggestion,
        author: s.auteur || 'Inconnu',
        likes: s.like_souggestion || 0,
        dislikes: s.dislike_souggestion || 0,
        userVote: s.user_vote, // 'like', 'dislike', or null
        date: s.inserted_at,
        category: s.category || 'Général',
      }))
    }
  } catch (err) {
    console.error('Erreur chargement suggestions', err)
  } finally {
    loading.value = false
  }
})

const addSuggestion = async () => {
  if (!formValid.value || submitting.value) return

  submitting.value = true
  try {
    const payload = {
      souggestion: {
        titre_souggestion: formData.value.title,
        contenu_souggestion: formData.value.description,
        category: formData.value.category
      }
    }
    const res = await createSuggestion(payload)
    if (res && res.data) {
      const s = res.data
      suggestions.value.unshift({
        id: s.id,
        title: s.titre_souggestion,
        description: s.contenu_souggestion,
        author: s.auteur || userName.value,
        likes: s.like_souggestion || 0,
        dislikes: s.dislike_souggestion || 0,
        userVote: s.user_vote || null,
        date: s.inserted_at,
        category: s.category || formData.value.category,
      })
    }
    formData.value = { title: '', description: '', category: '' }
    showForm.value = false
    showToast('Suggestion publiée avec succès !')
  } catch (err) {
    console.error('Erreur création suggestion', err)
    showToast('Impossible de publier la suggestion', 'error')
  } finally {
    submitting.value = false
  }
}

const handleVote = async (id, requestedVoteType) => {
  if (votingId.value) return
  votingId.value = id
  try {
    const idx = suggestions.value.findIndex(s => s.id === id)
    if (idx === -1) return

    const s = suggestions.value[idx]
    const currentVote = s.userVote

    // Backup state for rollback
    const backup = { userVote: s.userVote, likes: s.likes, dislikes: s.dislikes }

    // Optimistic update
    if (currentVote === requestedVoteType) {
      // Toggle off
      s.userVote = null
      s[requestedVoteType + 's'] = Math.max(0, s[requestedVoteType + 's'] - 1)
    } else {
      // Switch or new vote
      if (currentVote) {
        s[currentVote + 's'] = Math.max(0, s[currentVote + 's'] - 1)
      }
      s.userVote = requestedVoteType
      s[requestedVoteType + 's'] += 1
    }

    try {
      const res = await voteSuggestion(id, requestedVoteType)
      if (res && res.data) {
        s.likes = res.data.like_souggestion ?? s.likes
        s.dislikes = res.data.dislike_souggestion ?? s.dislikes
        s.userVote = res.data.user_vote ?? s.userVote
      }
    } catch (err) {
      // Revert optimistic update on failure
      Object.assign(s, backup)
      console.error('Vote failed', err)
      showToast('Erreur lors du vote', 'error')
    }
  } finally {
    votingId.value = null
  }
}

// Filtered & sorted suggestions
const filteredSuggestions = computed(() => {
  let list = [...suggestions.value]

  // Filter by category
  if (activeFilter.value === 'mine') {
    list = list.filter(s => s.author === userName.value)
  } else if (activeFilter.value !== 'all') {
    list = list.filter(s => s.category === activeFilter.value)
  }

  // Filter by search
  if (searchQuery.value.trim()) {
    const query = searchQuery.value.toLowerCase().trim()
    list = list.filter(s =>
      s.title.toLowerCase().includes(query) ||
      s.description.toLowerCase().includes(query) ||
      s.author.toLowerCase().includes(query)
    )
  }

  // Sort by votes descending
  return list.sort((a, b) => b.votes - a.votes)
})

const totalVotes = computed(() => suggestions.value.reduce((acc, s) => acc + s.votes, 0))
const myVotesCount = computed(() => suggestions.value.filter((s) => s.voted).length)
</script>

<style scoped>
/* Slide-fade animation for the form */
.slide-fade-enter-active {
  transition: all 0.3s ease-out;
}
.slide-fade-leave-active {
  transition: all 0.2s ease-in;
}
.slide-fade-enter-from {
  opacity: 0;
  transform: translateY(-12px);
}
.slide-fade-leave-to {
  opacity: 0;
  transform: translateY(-8px);
}

/* List transition */
.list-enter-active {
  transition: all 0.4s ease-out;
}
.list-leave-active {
  transition: all 0.25s ease-in;
}
.list-enter-from {
  opacity: 0;
  transform: translateY(16px);
}
.list-leave-to {
  opacity: 0;
  transform: translateX(-20px);
}
.list-move {
  transition: transform 0.35s ease;
}

/* Toast transition */
.toast-enter-active {
  transition: all 0.35s ease-out;
}
.toast-leave-active {
  transition: all 0.25s ease-in;
}
.toast-enter-from {
  opacity: 0;
  transform: translateY(-20px) scale(0.95);
}
.toast-leave-to {
  opacity: 0;
  transform: translateY(-10px) scale(0.97);
}

/* Pulse animation for loading */
@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.4; }
}
.animate-pulse {
  animation: pulse 1.5s ease-in-out infinite;
}

/* Spin animation for loader */
@keyframes spin {
  to { transform: rotate(360deg); }
}
.animate-spin {
  animation: spin 0.8s linear infinite;
}
</style>