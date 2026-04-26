import { request, authHeaders } from './api'

export async function getProfile() {
  return await request('/api/auth/accounts/profile', { headers: authHeaders() })
}

export async function refreshSession() {
  return await request('/api/auth/accounts/refresh', { headers: authHeaders() })
}

export async function updateAccount(account) {
  return await request('/api/auth/accounts/update', {
    method: 'POST',
    headers: authHeaders(),
    body: JSON.stringify({ account }),
  })
}
