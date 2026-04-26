<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
      <div>
        <h1 class="text-2xl font-bold text-gray-900">Tableau de bord</h1>
        <p class="text-gray-600 mt-1">Bienvenue, {{ studentName }}</p>
      </div>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
      <!-- Total Modules -->
      <div class="bg-white rounded-lg p-6 border border-gray-200 shadow-sm">
        <div class="flex items-center justify-between mb-3">
          <BookOpen class="w-6 h-6 text-indigo-600" />
          <span class="text-xs font-semibold px-2 py-1 bg-indigo-100 text-indigo-700 rounded">Total</span>
        </div>
        <p class="text-sm text-gray-600 font-medium">Modules</p>
        <p class="text-3xl font-bold text-gray-900 mt-1">{{ totalModules }}</p>
        <p class="text-xs text-gray-500 mt-2">modules inscrits</p>
      </div>

      <!-- Average Progress -->
      <div class="bg-white rounded-lg p-6 border border-gray-200 shadow-sm">
        <div class="flex items-center justify-between mb-3">
          <TrendingUp class="w-6 h-6 text-green-600" />
          <span class="text-xs font-semibold px-2 py-1 bg-green-100 text-green-700 rounded">Moyenne</span>
        </div>
        <p class="text-sm text-gray-600 font-medium">Progression</p>
        <p class="text-3xl font-bold text-gray-900 mt-1">{{ averageProgress }}%</p>
        <p class="text-xs text-gray-500 mt-2">progression moyenne</p>
      </div>

      <!-- Announcements -->
      <div class="bg-white rounded-lg p-6 border border-gray-200 shadow-sm">
        <div class="flex items-center justify-between mb-3">
          <Bell class="w-6 h-6 text-blue-600" />
          <span class="text-xs font-semibold px-2 py-1 bg-blue-100 text-blue-700 rounded">Nouveau</span>
        </div>
        <p class="text-sm text-gray-600 font-medium">Annonces</p>
        <p class="text-3xl font-bold text-gray-900 mt-1">{{ announcements.length }}</p>
        <p class="text-xs text-gray-500 mt-2">annonces récentes</p>
      </div>

      <!-- Suggestions -->
      <div class="bg-white rounded-lg p-6 border border-gray-200 shadow-sm">
        <div class="flex items-center justify-between mb-3">
          <MessageSquare class="w-6 h-6 text-purple-600" />
          <span class="text-xs font-semibold px-2 py-1 bg-purple-100 text-purple-700 rounded">Action</span>
        </div>
        <p class="text-sm text-gray-600 font-medium">Suggestions</p>
        <p class="text-3xl font-bold text-gray-900 mt-1">0</p>
        <p class="text-xs text-gray-500 mt-2">partager votre avis</p>
      </div>
    </div>

    <!-- Main Content Row -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <!-- Left Column: Modules Progress (2/3 width) -->
      <div class="lg:col-span-2">
        <div class="bg-white rounded-lg border border-gray-200 p-6">
          <div class="flex items-center justify-between mb-6">
            <h2 class="text-lg font-semibold text-gray-900">Modules Inscrits</h2>
            <router-link
              to="/student/modules"
              class="text-indigo-600 hover:text-indigo-700 text-sm font-medium"
            >
              Voir plus →
            </router-link>
          </div>

          <div v-if="modules.length > 0" class="space-y-4">
            <div
              v-for="module in modules.slice(0, 3)"
              :key="module.id"
              class="p-4 border border-gray-200 rounded-lg hover:border-indigo-300 transition-colors"
            >
              <div class="flex items-start justify-between gap-4 mb-3">
                <div class="flex-1">
                  <h3 class="font-semibold text-gray-900">{{ module.intitule_cours }}</h3>
                  <p class="text-sm text-gray-600 mt-1">Code: {{ module.code_cours }}</p>
                </div>
                <span v-if="module.module_progress" :class="getProgressBadgeColor(module.module_progress)">
                  {{ module.module_progress }}%
                </span>
              </div>
              <div class="w-full bg-gray-200 rounded-full h-2">
                <div
                  :class="getProgressBarColor(module.module_progress || 0)"
                  class="h-2 rounded-full transition-all"
                  :style="{ width: `${module.module_progress || 0}%` }"
                />
              </div>
            </div>
          </div>
          <div v-else class="text-center py-12">
            <BookOpen class="w-12 h-12 text-gray-300 mx-auto mb-3" />
            <p class="text-gray-500 font-medium">Aucun module trouvé</p>
            <p class="text-sm text-gray-400 mt-1">Vous n'êtes inscrit à aucun module</p>
          </div>
        </div>
      </div>

      <!-- Right Column: Quick Links (1/3 width) -->
      <div class="space-y-6">
        <!-- Announcements Preview -->
        <div class="bg-white rounded-lg border border-gray-200 p-6">
          <h3 class="font-semibold text-gray-900 mb-4">Annonces Récentes</h3>
          <div v-if="announcements.length > 0" class="space-y-3">
            <div
              v-for="announcement in announcements.slice(0, 3)"
              :key="announcement.id"
              class="p-3 bg-gray-50 rounded-lg border border-gray-100 text-sm"
            >
              <p class="font-medium text-gray-900 line-clamp-2">{{ announcement.titre_annonce }}</p>
              <p class="text-xs text-gray-500 mt-1">
                {{ formatDate(announcement.date_publication_annonce) }}
              </p>
            </div>
            <router-link
              to="/student/announcements"
              class="block text-center py-2 text-indigo-600 hover:text-indigo-700 text-sm font-medium border-t border-gray-200 mt-3 pt-3"
            >
              Voir toutes les annonces
            </router-link>
          </div>
          <div v-else class="text-center py-8">
            <Bell class="w-8 h-8 text-gray-300 mx-auto mb-2" />
            <p class="text-gray-500 text-sm">Aucune annonce</p>
          </div>
        </div>

        <!-- Quick Actions -->
        <div class="bg-indigo-50 rounded-lg border border-indigo-200 p-6">
          <h3 class="font-semibold text-indigo-900 mb-4">Actions Rapides</h3>
          <div class="space-y-2">
            <router-link
              to="/student/suggestions"
              class="flex items-center gap-3 p-3 bg-white rounded-lg hover:bg-indigo-50 text-gray-900 transition-colors"
            >
              <MessageSquare class="w-5 h-5 text-indigo-600 flex-shrink-0" />
              <span class="text-sm font-medium">Faire une suggestion</span>
            </router-link>
            <router-link
              to="/student/tickets"
              class="flex items-center gap-3 p-3 bg-white rounded-lg hover:bg-indigo-50 text-gray-900 transition-colors"
            >
              <FileText class="w-5 h-5 text-indigo-600 flex-shrink-0" />
              <span class="text-sm font-medium">Soumettre une réclamation</span>
            </router-link>
            <router-link
              to="/student/profile"
              class="flex items-center gap-3 p-3 bg-white rounded-lg hover:bg-indigo-50 text-gray-900 transition-colors"
            >
              <User class="w-5 h-5 text-indigo-600 flex-shrink-0" />
              <span class="text-sm font-medium">Voir mon profil</span>
            </router-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { BookOpen, TrendingUp, Bell, MessageSquare, FileText, User } from 'lucide-vue-next'
import { studentModulesProgress } from '../../../composables/useModules'
import { useAuth } from '../../../composables/useAuth'
import { request, authHeaders } from '../../../composables/api'

const modules = ref([])
const announcements = ref([])
const { user } = useAuth()

const studentName = computed(() => {
  if (!user.value) return 'Étudiant'
  const name = user.value.name || `${user.value.prenom_utilisateurs || ''} ${user.value.nom_utilisateurs || ''}`.trim()
  return name || 'Étudiant'
})

const totalModules = computed(() => modules.value.length)

const averageProgress = computed(() => {
  if (modules.value.length === 0) return 0
  const total = modules.value.reduce((sum, m) => sum + (m.module_progress || 0), 0)
  return Math.round(total / modules.value.length)
})

const getProgressColor = (progress) => {
  if (progress >= 80) return 'bg-green-500'
  if (progress >= 60) return 'bg-blue-500'
  if (progress >= 40) return 'bg-yellow-500'
  return 'bg-red-500'
}

const getProgressBarColor = (progress) => {
  if (progress >= 80) return 'bg-green-500'
  if (progress >= 60) return 'bg-blue-500'
  if (progress >= 40) return 'bg-yellow-500'
  return 'bg-red-500'
}

const getProgressBadgeColor = (progress) => {
  if (progress >= 80) return 'px-3 py-1 bg-green-100 text-green-700 text-sm font-semibold rounded'
  if (progress >= 60) return 'px-3 py-1 bg-blue-100 text-blue-700 text-sm font-semibold rounded'
  if (progress >= 40) return 'px-3 py-1 bg-yellow-100 text-yellow-700 text-sm font-semibold rounded'
  return 'px-3 py-1 bg-red-100 text-red-700 text-sm font-semibold rounded'
}

const formatDate = (dateString) => {
  if (!dateString) return ''
  const date = new Date(dateString)
  return new Intl.DateTimeFormat('fr-FR', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  }).format(date)
}

async function loadModules() {
  try {
    const response = await studentModulesProgress()
    if (response && response.data) {
      modules.value = response.data
    }
  } catch (e) {
    console.error('Failed to load student modules:', e)
  }
}

async function loadAnnouncements() {
  try {
    const response = await request('/api/auth/annonces', { headers: authHeaders() })
    if (response && response.data) {
      announcements.value = response.data
    }
  } catch (e) {
    console.error('Failed to load announcements:', e)
  }
}

onMounted(async () => {
  await loadModules()
  await loadAnnouncements()
})
</script>

<style scoped>
.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
