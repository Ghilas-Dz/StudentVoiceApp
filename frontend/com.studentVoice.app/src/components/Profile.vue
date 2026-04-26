<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
      <div>
        <h1 class="text-3xl font-bold text-gray-900">Mon Profil</h1>
        <p class="text-gray-600 mt-1">Gérez vos informations personnelles</p>
      </div>
      <div v-if="!isEditing">
        <button
          @click="isEditing = true"
          class="flex items-center gap-1.5 px-4 py-2.5 rounded-xl text-white text-sm transition-all hover:opacity-90 active:scale-95 shadow-lg shadow-blue-500/20"
        style="background: linear-gradient(135deg, var(--blue-dark) 0%, var(--blue) 50%, var(--blue-deep) 100%); --blue: #255fe3; --blue-dark: #1f54d2; --blue-deep: #1d3f95; font-weight: 600">
          <Edit2 class="w-5 h-5" />
          Modifier le profil
        </button>
      </div>
      <div v-else class="flex gap-3">
        <button
          @click="handleSave"
          class="flex items-center gap-1.5 px-4 py-2.5 rounded-xl text-white text-sm transition-all hover:opacity-90 active:scale-95 shadow-lg shadow-blue-500/20"
        style="background: linear-gradient(135deg, #128c3e 0%, #16A34A 50%, #0f7a35 100%)">
          <Save class="w-5 h-5" />
          Enregistrer
        </button>
        <button
          @click="handleCancel"
          class="inline-flex items-center gap-2 px-4 py-2 text-white rounded-lg hover:bg-gray-300 transition-colors"
        style="background: linear-gradient(135deg, #c41e1e 0%, #DC2626 50%, #a51b1b 100%)">
          <X class="w-5 h-5" />
          Annuler
        </button>
      </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <!-- Profile Card -->
      <div class="lg:col-span-1">
        <div class="bg-white dark:bg-slate-800 p-6 rounded-3xl border border-blue-100 dark:border-blue-900 shadow-lg shadow-blue-500/5 animate-slide-down">
          <div class="w-32 h-32 mx-auto mb-4 bg-gradient-to-br from-indigo-600 to-purple-600 rounded-full flex items-center justify-center">
            <User class="w-16 h-16 text-white" />
          </div>
          <h2 class="text-2xl font-bold text-gray-900 mb-2">{{ user?.name || 'Utilisateur' }}</h2>
          <p class="text-gray-600 mb-4">{{ user?.email || '-' }}</p>

          <div class="mt-6 pt-6 border-t border-gray-200 space-y-3 text-left">
            <div class="flex items-center gap-3 text-sm">
              <BookOpen class="w-5 h-5 text-gray-400" />
              <div>
                <p class="text-gray-500">Classe</p>
                <p class="font-medium text-gray-900">{{ user?.class || 'N/A' }}</p>
              </div>
            </div>
            <div class="flex items-center gap-3 text-sm">
              <MapPin class="w-5 h-5 text-gray-400" />
              <div>
                <p class="text-gray-500">Département</p>
                <p class="font-medium text-gray-900">{{ user?.department || 'N/A' }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Information Form -->
      <div class="lg:col-span-2 space-y-6">
        <!-- Personal Information -->
        <div class="bg-white dark:bg-slate-800 p-6 rounded-3xl border border-blue-100 dark:border-blue-900 shadow-lg shadow-blue-500/5 animate-slide-down">
          <h3 class="text-xl font-semibold text-gray-900 mb-6">Informations personnelles</h3>

          <div class="space-y-4">
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Nom complet</label>
                <input v-if="isEditing" type="text" v-model="formData.name" />
                <div v-else class="flex items-center gap-2 px-4 py-2 bg-gray-50 rounded-lg">
                  <UserIcon class="w-5 h-5 text-gray-400" />
                  <span class="text-gray-900">{{ formData.name }}</span>
                </div>
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                <input v-if="isEditing" type="email" v-model="formData.email" />
                <div v-else class="flex items-center gap-2 px-4 py-2 bg-gray-50 rounded-lg">
                  <Mail class="w-5 h-5 text-gray-400" />
                  <span class="text-gray-900">{{ formData.email }}</span>
                </div>
              </div>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Téléphone</label>
                <input v-if="isEditing" type="tel" v-model="formData.phone" />
                <div v-else class="flex items-center gap-2 px-4 py-2 bg-gray-50 rounded-lg">
                  <Phone class="w-5 h-5 text-gray-400" />
                  <span class="text-gray-900">{{ formData.phone }}</span>
                </div>
              </div>

              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Date de naissance</label>
                <input v-if="isEditing" type="date" v-model="formData.dateOfBirth" />
                <div v-else class="flex items-center gap-2 px-4 py-2 bg-gray-50 rounded-lg">
                  <Calendar class="w-5 h-5 text-gray-400" />
                  <span class="text-gray-900">{{ formData.dateOfBirth }}</span>
                </div>
              </div>
            </div>

            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Adresse</label>
              <input v-if="isEditing" type="text" v-model="formData.address" />
              <div v-else class="flex items-center gap-2 px-4 py-2 bg-gray-50 rounded-lg">
                <MapPin class="w-5 h-5 text-gray-400" />
                <span class="text-gray-900">{{ formData.address }}</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Academic Information -->
        <div v-if="!user?.professeur" class="bg-white dark:bg-slate-800 p-6 rounded-3xl border border-blue-100 dark:border-blue-900 shadow-lg shadow-blue-500/5 animate-slide-down">
          <h3 class="text-xl font-semibold text-gray-900 mb-6">Informations académiques</h3>

          <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Classe</label>
              <div class="flex items-center gap-2 px-4 py-2 bg-gray-50 rounded-lg">
                <BookOpen class="w-5 h-5 text-gray-400" />
                <span class="text-gray-900">{{ formData.class || 'N/A' }}</span>
              </div>
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Filière</label>
              <div class="flex items-center gap-2 px-4 py-2 bg-gray-50 rounded-lg">
                <BookOpen class="w-5 h-5 text-gray-400" />
                <span class="text-gray-900">{{ formData.filiere || 'N/A' }}</span>
              </div>
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Niveau</label>
              <div class="flex items-center gap-2 px-4 py-2 bg-gray-50 rounded-lg">
                <BookOpen class="w-5 h-5 text-gray-400" />
                <span class="text-gray-900">{{ formData.niveau || 'N/A' }}</span>
              </div>
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Statut délégué</label>
              <div class="flex items-center gap-2 px-4 py-2 bg-gray-50 rounded-lg">
                <BookOpen class="w-5 h-5 text-gray-400" />
                <span class="text-gray-900">{{ formData.is_delegate ? 'Délégué' : 'Non délégué' }}</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Professor Information -->
        <div v-if="user?.professeur" class="bg-white dark:bg-slate-800 p-6 rounded-3xl border border-blue-100 dark:border-blue-900 shadow-lg shadow-blue-500/5 animate-slide-down">
          <h3 class="text-xl font-semibold text-gray-900 mb-6">Informations Professeur</h3>

          <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Grade</label>
              <input v-if="isEditing" type="text" v-model="formData.grade" />
              <div v-else class="flex items-center gap-2 px-4 py-2 bg-gray-50 rounded-lg">
                <BookOpen class="w-5 h-5 text-gray-400" />
                <span class="text-gray-900">{{ formData.grade || 'N/A' }}</span>
              </div>
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Spécialité</label>
              <input v-if="isEditing" type="text" v-model="formData.specialite" />
              <div v-else class="flex items-center gap-2 px-4 py-2 bg-gray-50 rounded-lg">
                <BookOpen class="w-5 h-5 text-gray-400" />
                <span class="text-gray-900">{{ formData.specialite || 'N/A' }}</span>
              </div>
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Téléphone professionnel</label>
              <input v-if="isEditing" type="tel" v-model="formData.telephoneProf" />
              <div v-else class="flex items-center gap-2 px-4 py-2 bg-gray-50 rounded-lg">
                <Phone class="w-5 h-5 text-gray-400" />
                <span class="text-gray-900">{{ formData.telephoneProf || 'N/A' }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue'
import { User, Mail, Phone, MapPin, Calendar, BookOpen, Edit2, Save, X } from 'lucide-vue-next'
import { useAuth } from '../composables/useAuth'

// Alias to avoid naming conflict with lucide User icon
const UserIcon = User

const { user, loadProfile } = useAuth()

const isEditing = ref(false)

const formData = ref({
  name: '',
  email: '',
  phone: '',
  address: '',
  dateOfBirth: '',
  class: '',
  department: '',
  groupe: '',
  filiere: '',
  niveau: '',
  is_delegate: false,
  // professor fields
  grade: '',
  specialite: '',
  telephoneProf: '',
})

const applyUserToForm = (u) => {
  if (!u) return
  formData.value.name = u.name || ''
  formData.value.email = u.email || ''
  // Use student phone for students, professor phone for professors
  if (u.professeur) {
    formData.value.phone = u.telephoneProf || ''
  } else {
    formData.value.phone = u.telephone || ''
  }
  formData.value.dateOfBirth = u.dateNaissance || ''
  // map groupe -> class, filiere, niveau when available
  if (u.groupe && u.groupe.libele) {
    formData.value.groupe = u.groupe.libele
    formData.value.class = u.groupe.libele
    formData.value.filiere = u.groupe.filiere || ''
    formData.value.niveau = u.groupe.niveau || ''
  }
  // map delegate status
  formData.value.is_delegate = u.is_delegate || false
  // professor fields
  formData.value.grade = u.grade || ''
  formData.value.specialite = u.specialite || ''
  formData.value.telephoneProf = u.telephoneProf || ''
}

watch(user, (newVal) => {
  applyUserToForm(newVal)
}, { immediate: true })

onMounted(async () => {
  try {
    // ensure profile is loaded
    await loadProfile()
  } catch (e) {
    // ignore
  }
  applyUserToForm(user.value)
})

const handleSave = () => {
  isEditing.value = false
}

const handleCancel = () => {
  applyUserToForm(user.value)
  isEditing.value = false
}
</script>