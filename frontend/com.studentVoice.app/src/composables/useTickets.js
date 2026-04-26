import { request, authHeaders } from './api'

let ticketsCache = null

export async function listTickets(force = false) {
  if (!force && ticketsCache) return { data: ticketsCache }
  const res = await request('/api/auth/tickets', { headers: authHeaders() })
  if (res && res.data) ticketsCache = res.data
  return res
}

export async function getTicket(id) {
  return await request(`/api/auth/tickets/${id}`, { headers: authHeaders() })
}

export async function createTicket(payload) {
  return await request('/api/auth/tickets', {
    method: 'POST',
    headers: authHeaders(),
    body: JSON.stringify(payload),
  })
}

export async function updateTicket(id, payload) {
  const res = await request(`/api/auth/tickets/${id}`, {
    method: 'PUT',
    headers: authHeaders(),
    body: JSON.stringify(payload),
  })
  // invalidate cache on update
  ticketsCache = null
  return res
}

export async function deleteTicket(id) {
  const res = await request(`/api/auth/tickets/${id}`, {
    method: 'DELETE',
    headers: authHeaders(),
  })
  ticketsCache = null
  return res
}

export async function getTicketComments(id) {
  return await request(`/api/auth/tickets/${id}/comments`, { headers: authHeaders() })
}

export async function addTicketComment(id, payload) {
  return await request(`/api/auth/tickets/${id}/comments`, {
    method: 'POST',
    headers: authHeaders(),
    body: JSON.stringify(payload),
  })
}

export async function myTicketStatus() {
  return await request('/api/auth/tickets/status', { headers: authHeaders() })
}

export async function ticketsStats() {
  return await request('/api/auth/tickets/stats', { headers: authHeaders() })
}

export async function listTicketsForProf() {
  return await request('/api/auth/professeur/tickets/modules', { headers: authHeaders() })
}
