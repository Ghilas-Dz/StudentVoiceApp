import { ref } from 'vue'
import { request, authHeaders } from './api'

const students = ref([])

export function useStudents() {
  const addStudent = (newStudent) => {
    const id = Math.max(...students.value.map(s => s.id), 0) + 1
    students.value.push({
      id,
      ...newStudent,
      average: 0,
      status: 'actif',
    })
  }

  async function deleteStudent(id) {
    await request(`/api/auth/professeur/students/${id}`, {
      method: 'DELETE',
      headers: authHeaders(),
    })
    await fetchProfessorStudents()
  }

  async function fetchStudents() {
    try {
      const res = await request('/api/auth/admin/utilisateurs', { headers: authHeaders() })
      const arr = (res && res.data) ? res.data : res
      if (Array.isArray(arr)) {
        // map to simple student shape when possible
        students.value = arr.map((u, idx) => ({
          id: u.id || idx + 1,
          name: `${u.prenom_utilisateurs || ''} ${u.nom_utilisateurs || ''}`.trim() || u.email_utilisateurs || 'Étudiant',
          email: u.email_utilisateurs || '',
          phone: u.etudiant && u.etudiant.telephone_etudiant ? u.etudiant.telephone_etudiant : '',
          course: (u.etudiant && u.etudiant.groupe && u.etudiant.groupe.modules && u.etudiant.groupe.modules[0] && u.etudiant.groupe.modules[0].intitule_cours) || '',
          average: 0,
          status: 'actif'
        }))
      }
    } catch (e) {
      console.debug('fetchStudents failed', e)
      students.value = []
    }
  }

  async function fetchProfessorStudents() {
    try {
      const res = await request('/api/auth/professeur/students', { headers: authHeaders() })
      const arr = (res && res.data) ? res.data : []
      if (Array.isArray(arr)) {
        students.value = arr.map((student) => ({
          id: student.id,
          name: student.name,
          email: student.email,
          phone: student.phone || '',
          course: student.group || '',
          average: 0,
          status: 'actif',
          is_delegate: student.is_delegate || false
        }))
      }
    } catch (e) {
      console.error('Failed to fetch professor students', e)
      students.value = []
    }
  }

  async function createProfessorStudent(studentPayload) {
    const fullName = (studentPayload.name || '').trim()
    const parts = fullName.split(/\s+/).filter(Boolean)
    const prenom = parts[0] || 'Etudiant'
    const nom = parts.slice(1).join(' ') || 'Nouveau'

    const account = {
      email_utilisateurs: (studentPayload.email || '').trim().toLowerCase(),
      password: studentPayload.password || 'Student123',
      prenom_utilisateurs: prenom,
      nom_utilisateurs: nom,
      role: 'etudiant',
      groupe: studentPayload.course || 'A',
      date_naissance_etudiant: studentPayload.date_naissance_etudiant || '2000-01-01',
      telephone_etudiant: studentPayload.phone || '',
    }

    const created = await request('/api/auth/professeur/students', {
      method: 'POST',
      headers: authHeaders(),
      body: JSON.stringify({ account }),
    })

    await fetchProfessorStudents()
    return created
  }

  async function searchAllStudents(query) {
    try {
      const res = await request(`/api/auth/professeur/search-students?q=${encodeURIComponent(query)}`, {
        headers: authHeaders(),
      })
      return res && res.data ? res.data : []
    } catch (e) {
      console.error('Failed to search students', e)
      return []
    }
  }

  async function attachStudentToModule(studentId, moduleId) {
    try {
      const res = await request('/api/auth/professeur/attach-student', {
        method: 'POST',
        headers: authHeaders(),
        body: JSON.stringify({ student_id: studentId, module_id: moduleId }),
      })
      await fetchProfessorStudents()
      return res
    } catch (e) {
      console.error('Failed to attach student', e)
      throw e
    }
  }

  return { students, addStudent, deleteStudent, fetchStudents, fetchProfessorStudents, createProfessorStudent, searchAllStudents, attachStudentToModule }
}

