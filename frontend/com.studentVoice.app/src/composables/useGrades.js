import { ref } from 'vue'
import { request, authHeaders } from './api'

const grades = ref([])
const loading = ref(false)
const error = ref(null)

export function useGrades() {
  const fetchGrades = async () => {
    loading.value = true
    error.value = null
    try {
      const res = await request('/api/auth/professeur/grades', { headers: authHeaders() })
      grades.value = (res && res.data) ? res.data : []
    } catch (e) {
      console.error('Failed to fetch grades', e)
      error.value = e?.message || 'Erreur lors du chargement des notes'
      grades.value = []
    } finally {
      loading.value = false
    }
  }

  const fetchGradesByModule = async (moduleId) => {
    loading.value = true
    error.value = null
    try {
      const res = await request(`/api/auth/professeur/grades/module/${moduleId}`, { headers: authHeaders() })
      grades.value = (res && res.data) ? res.data : []
    } catch (e) {
      console.error('Failed to fetch module grades', e)
      error.value = e?.message || 'Erreur lors du chargement des notes'
      grades.value = []
    } finally {
      loading.value = false
    }
  }

  const addGrade = async (gradeData) => {
    try {
      const res = await request('/api/auth/professeur/grades', {
        method: 'POST',
        headers: authHeaders(),
        body: JSON.stringify({ grade: gradeData })
      })
      if (res && res.data) {
        grades.value.push(res.data)
      }
      return res.data
    } catch (e) {
      console.error('Failed to add grade', e)
      error.value = e?.message || 'Erreur lors de l\'ajout de la note'
      throw e
    }
  }

  const updateGrade = async (gradeId, gradeData) => {
    try {
      const res = await request(`/api/auth/professeur/grades/${gradeId}`, {
        method: 'PUT',
        headers: authHeaders(),
        body: JSON.stringify({ grade: gradeData })
      })
      if (res && res.data) {
        const idx = grades.value.findIndex(g => g.id === gradeId)
        if (idx >= 0) {
          grades.value[idx] = res.data
        }
      }
      return res.data
    } catch (e) {
      console.error('Failed to update grade', e)
      error.value = e?.message || 'Erreur lors de la mise à jour de la note'
      throw e
    }
  }

  const deleteGrade = async (gradeId) => {
    try {
      await request(`/api/auth/professeur/grades/${gradeId}`, {
        method: 'DELETE',
        headers: authHeaders()
      })
      grades.value = grades.value.filter(g => g.id !== gradeId)
    } catch (e) {
      console.error('Failed to delete grade', e)
      error.value = e?.message || 'Erreur lors de la suppression de la note'
      throw e
    }
  }

  return {
    grades,
    loading,
    error,
    fetchGrades,
    fetchGradesByModule,
    addGrade,
    updateGrade,
    deleteGrade
  }
}
