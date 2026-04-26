import { request, authHeaders } from './api'

let usersCache = null

export async function decideTicket(ticket_id, payload) {
  return await request(`/api/auth/admin/tickets/${ticket_id}/decide`, {
    method: 'POST',
    headers: authHeaders(),
    body: JSON.stringify(payload),
  })
}

export async function adminTicketsStats() {
  try {
    console.debug('[useAdmin] adminTicketsStats headers', authHeaders())
    const res = await request('/api/auth/admin/tickets/stats', { headers: authHeaders() })
    console.debug('[useAdmin] adminTicketsStats res', res)
    return res
  } catch (e) {
    console.debug('[useAdmin] adminTicketsStats error', e)
    throw e
  }
}

export async function designateDelegate(etudiant_id, payload) {
  const res = await request(`/api/auth/admin/etudiants/${etudiant_id}/delegate`, {
    method: 'PUT',
    headers: authHeaders(),
    body: JSON.stringify(payload),
  })
  usersCache = null
  return res
}

export async function createEtudiant(account) {
  // account should be an object matching backend expected keys
  const res = await request('/api/etudiant/register', {
    method: 'POST',
    headers: authHeaders(),
    body: JSON.stringify({ account }),
  })
  // Invalidate cache so listUsers will refresh
  usersCache = null
  return res
}

export async function listUsers(force = false) {
  if (!force && usersCache) return { data: usersCache }
  const res = await request('/api/auth/admin/utilisateurs', { headers: authHeaders() })
  // backend returns { data: [...] }
  const arr = (res && res.data) ? res.data : res
  if (arr) usersCache = arr
  console.debug('[useAdmin] /utilisateurs ->', arr)
  return { data: arr }
}

export async function deleteUser(id) {
  const res = await request(`/api/auth/admin/utilisateurs/${id}`, {
    method: 'DELETE',
    headers: authHeaders()
  })
  usersCache = null
  return res
}
