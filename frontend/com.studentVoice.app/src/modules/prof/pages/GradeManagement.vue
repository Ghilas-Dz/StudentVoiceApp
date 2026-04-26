<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex items-center justify-end">
      <div>
        <button
          @click="showAddForm = !showAddForm"
        class="flex items-center gap-1.5 px-4 py-2.5 rounded-xl text-white text-sm transition-all hover:opacity-90 active:scale-95 shadow-lg shadow-blue-500/20"
        style="background: linear-gradient(135deg, var(--blue-dark) 0%, var(--blue) 50%, var(--blue-deep) 100%); --blue: #255fe3; --blue-dark: #1f54d2; --blue-deep: #1d3f95; font-weight: 600">
          <Plus class="w-4 h-4" />
          Ajouter TD/TP
        </button>
      </div>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
      <div class="bg-white rounded-2xl p-6 border border-gray-200">
        <p class="text-sm text-gray-600 mb-2">Évaluations Saisies</p>
        <p class="text-3xl font-bold text-gray-900">
          {{ grades.length }}
        </p>
      </div>
      <div class="bg-white rounded-2xl p-6 border border-gray-200">
        <p class="text-sm text-gray-600 mb-2">Notes Validées (>= 10)</p>
        <p class="text-3xl font-bold text-gray-900">
          {{ passedGradesCount }}
        </p>
      </div>
      <div class="bg-white rounded-2xl p-6 border border-gray-200">
        <p class="text-sm text-gray-600 mb-2">Moyenne Générale</p>
        <p class="text-3xl font-bold text-gray-900">
          {{ averageGrade }}/20
        </p>
      </div>
      <div class="bg-white rounded-2xl p-6 border border-gray-200">
        <p class="text-sm text-gray-600 mb-2">Total Notes</p>
        <p class="text-3xl font-bold text-gray-900">{{ grades.length }}</p>
      </div>
    </div>

    <!-- Add Grade Form -->
    <div v-if="showAddForm" class="bg-white dark:bg-slate-800 p-6 rounded-3xl border border-blue-100 dark:border-blue-900 shadow-lg shadow-blue-500/5 animate-slide-down">
      <h3 class="text-sm mb-4" :style="{ color: 'var(--foreground)', fontWeight: '700' }">Ajouter TD/TP + Examen</h3>
      <form @submit.prevent="handleAddGrade" class="space-y-4">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div class="space-y-1.5">
            <label class="text-[10px] font-bold text-gray-400 uppercase tracking-wider ml-1">Étudiant</label>
            <CustomSelect
              v-model="newGrade.etudiant_id"
              :options="studentOptions"
              placeholder="Sélectionner un étudiant"
            />
          </div>
          <div class="space-y-1.5">
            <label class="text-[10px] font-bold text-gray-400 uppercase tracking-wider ml-1">Cours</label>
            <CustomSelect
              v-model="newGrade.module_id"
              :options="moduleOptions"
              placeholder="Sélectionner un cours"
            />
          </div>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div class="space-y-1.5">
            <label class="text-[10px] font-bold text-gray-400 uppercase tracking-wider ml-1">Note TD/TP (sur 20)</label>
            <input
              type="number"
              step="0.5"
              min="0"
              max="20"
              v-model="newGrade.note_td_tp"
              placeholder="0.0"
              class="w-full px-4 py-2 rounded-xl border border-gray-200 bg-gray-50/50 text-sm focus:ring-2 focus:ring-blue-500 outline-none transition-all"
              required
            />
          </div>
          <div class="space-y-1.5">
            <label class="text-[10px] font-bold text-gray-400 uppercase tracking-wider ml-1">Note Examen (sur 20)</label>
            <input
              type="number"
              step="0.5"
              min="0"
              max="20"
              v-model="newGrade.note_examen"
              placeholder="0.0"
              class="w-full px-4 py-2 rounded-xl border border-gray-200 bg-gray-50/50 text-sm focus:ring-2 focus:ring-blue-500 outline-none transition-all"
              required
            />
          </div>
        </div>
        <div class="flex justify-start gap-3 pt-2">
          <button
            type="button"
            @click="showAddForm = false"
            class="px-5 py-2.5 rounded-xl text-sm transition-all hover:bg-gray-100" :style="{ color: 'var(--muted-foreground)', fontWeight: '600' }"
          >
            Annuler
          </button>
          <button
            type="submit"
            :disabled="loading"
            class="px-8 py-2.5 rounded-xl text-white text-sm transition-all hover:opacity-90 active:scale-95 shadow-lg shadow-blue-500/20 disabled:opacity-50" 
            style="background: linear-gradient(135deg, #1f54d2 0%, #255fe3 50%, #1d3f95 100%); font-weight: 700">
            {{ loading ? 'Enregistrement...' : 'Enregistrer les notes' }}
          </button>
        </div>
      </form>
    </div>

    <!-- Grades Table -->
    <div class="bg-white rounded-2xl border border-gray-200 overflow-hidden">
      <div class="overflow-x-auto">
        <table class="w-full">
          <thead class="bg-white dark:bg-slate-800 p-6 rounded-3xl border border-blue-100 dark:border-blue-900 shadow-lg shadow-blue-500/5 animate-slide-down">
            <tr>
              <th class="text-left px-6 py-4 text-sm font-semibold text-gray-900">Étudiant</th>
              <th class="text-left px-6 py-4 text-sm font-semibold text-gray-900">Cours</th>
              <th class="text-left px-6 py-4 text-sm font-semibold text-gray-900">TD/TP</th>
              <th class="text-left px-6 py-4 text-sm font-semibold text-gray-900">Examen</th>
              <th class="text-left px-6 py-4 text-sm font-semibold text-gray-900">Date</th>
            </tr>
          </thead>
          <tbody >
            <tr
              v-for="grade in grades"
              :key="grade.id"
              class="hover:bg-gray-50 dark:hover:bg-[var(--hover)]"
            >
              <td class="px-6 py-4">
                <p class="font-semibold text-gray-900">{{ grade.etudiant?.name }}</p>
              </td>
              <td class="px-6 py-4">
                <span class="text-sm text-gray-900">{{ grade.module?.name }}</span>
              </td>
              <td class="px-6 py-4">
                <span
                  :class="[
                    'inline-flex items-center px-3 py-1 rounded-full text-sm font-bold',
                    getGradeColor(grade.note_td_tp, 20)
                  ]"
                >
                  {{ grade.note_td_tp }}/20
                </span>
              </td>
              <td class="px-6 py-4">
                <span
                  :class="[
                    'inline-flex items-center px-3 py-1 rounded-full text-sm font-bold',
                    getGradeColor(grade.note_examen, 20)
                  ]"
                >
                  {{ grade.note_examen }}/20
                </span>
              </td>
              <td class="px-6 py-4">
                <span class="text-sm text-gray-600">
                  {{ formatDate(grade.inserted_at) }}
                </span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { Plus, User, GraduationCap } from 'lucide-vue-next'
import { useStudents } from '../../../composables/useStudents'
import { useGrades } from '../../../composables/useGrades'
import { professeurModulesProgress } from '../../../composables/useModules'
import CustomSelect from '../../../components/CustomSelect.vue'

const { students, fetchProfessorStudents } = useStudents()
const { grades, fetchGrades, addGrade, loading } = useGrades()

const modules = ref([])
const showAddForm = ref(false)
const newGrade = ref({
  etudiant_id: '',
  module_id: '',
  note_td_tp: '',
  note_examen: '',
})

// Fetch data on component mount
onMounted(async () => {
  await fetchProfessorStudents()
  await fetchGrades()
  const { data: modulesData } = await professeurModulesProgress()
  modules.value = modulesData || []
})

// Dynamic student options from composable
const studentOptions = computed(() =>
  students.value.map(s => ({ 
    value: s.id, 
    label: s.name,
    icon: User
  }))
)

const moduleOptions = computed(() =>
  modules.value.map(m => ({ 
    value: m.module?.id || m.id, 
    label: m.module?.intitule_cours || m.name || 'Module',
    icon: GraduationCap,
    dot: '#818cf8'
  })) || []
)

// Compute stats from grades
const passedGradesCount = computed(() =>
  grades.value.filter(g => ((g.note_td_tp + g.note_examen) / 2) >= 10).length
)

const averageGrade = computed(() => {
  if (grades.value.length === 0) return 0
  const total = grades.value.reduce((acc, g) => acc + ((g.note_td_tp + g.note_examen) / 2), 0)
  return (total / grades.value.length).toFixed(1)
})

async function handleAddGrade() {
  if (
    newGrade.value.etudiant_id &&
    newGrade.value.module_id &&
    newGrade.value.note_td_tp &&
    newGrade.value.note_examen
  ) {
    try {
      await addGrade({
        etudiant_id: parseInt(newGrade.value.etudiant_id),
        module_id: parseInt(newGrade.value.module_id),
        note_td_tp: parseFloat(newGrade.value.note_td_tp),
        note_examen: parseFloat(newGrade.value.note_examen),
      })
      newGrade.value = { etudiant_id: '', module_id: '', note_td_tp: '', note_examen: '' }
      showAddForm.value = false
    } catch (e) {
      console.error('Error adding grade:', e)
    }
  }
}

function getGradeColor(grade, maxGrade) {
  const percentage = (grade / maxGrade) * 100
  if (percentage >= 80) return 'text-green-600 bg-green-100'
  if (percentage >= 70) return 'text-blue-600 bg-blue-100'
  if (percentage >= 60) return 'text-orange-600 bg-orange-100'
  return 'text-red-600 bg-red-100'
}

function formatDate(date) {
  return new Date(date).toLocaleDateString('fr-FR')
}

function getStudentName(studentId) {
  const student = students.value.find(s => s.id === studentId)
  return student?.name || 'N/A'
}

function getModuleName(moduleId) {
  const module = modules.value.find(m => m.module?.id === moduleId)
  return module?.module?.name || module?.module?.code || 'N/A'
}
</script>
