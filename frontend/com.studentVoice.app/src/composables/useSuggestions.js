import { request, authHeaders } from './api'

// General suggestions
export async function getSuggestions() {
  return await request('/api/auth/souggestions', { headers: authHeaders() })
}

export async function getSuggestion(id) {
  return await request(`/api/auth/souggestions/${id}`, { headers: authHeaders() })
}

// Student-scoped create/update/delete
export async function createSuggestion(payload) {
  return await request('/api/auth/etudiant/souggestions', {
    method: 'POST',
    headers: authHeaders(),
    body: JSON.stringify(payload),
  })
}

export async function updateSuggestion(id, payload) {
  return await request(`/api/auth/etudiant/souggestions/${id}`, {
    method: 'PUT',
    headers: authHeaders(),
    body: JSON.stringify(payload),
  })
}

export async function deleteSuggestion(id) {
  return await request(`/api/auth/etudiant/souggestions/${id}`, {
    method: 'DELETE',
    headers: authHeaders(),
  })
}

export async function voteSuggestion(id, voteType = 'like') {
  return await request(`/api/auth/souggestions/${id}/vote`, {
    method: 'POST',
    headers: authHeaders(),
    body: JSON.stringify({ vote: voteType }),
  })
}
