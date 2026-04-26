import { request, authHeaders } from './api'

export async function studentModulesProgress() {
  return await request('/api/auth/etudiant/modules/progress', { headers: authHeaders() })
}

export async function professeurModulesProgress() {
  return await request('/api/auth/professeur/modules/progress', { headers: authHeaders() })
}

export async function updateCourseProgress(module_id, payload) {
  return await request(`/api/auth/professeur/modules/${module_id}/progress`, {
    method: 'PUT',
    headers: authHeaders(),
    body: JSON.stringify(payload),
  })
}

export async function fetchChaptersForModule(moduleId) {
  return await request(`/api/auth/professeur/chapters/module/${moduleId}`, { headers: authHeaders() })
}

export async function createChapter(moduleId, chapterData) {
  return await request(`/api/auth/professeur/chapters/module/${moduleId}`, {
    method: 'POST',
    headers: authHeaders(),
    body: JSON.stringify(chapterData),
  })
}

export async function updateChapter(chapterId, chapterData) {
  return await request(`/api/auth/professeur/chapters/${chapterId}`, {
    method: 'PUT',
    headers: authHeaders(),
    body: JSON.stringify(chapterData),
  })
}

export async function deleteChapter(chapterId) {
  return await request(`/api/auth/professeur/chapters/${chapterId}`, {
    method: 'DELETE',
    headers: authHeaders(),
  })
}
