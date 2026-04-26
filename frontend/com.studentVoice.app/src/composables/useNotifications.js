import { request, authHeaders } from './api'

export async function getNotifications() {
  return await request('/api/auth/notifications', { headers: authHeaders() })
}
