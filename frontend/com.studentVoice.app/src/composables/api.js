const API_BASE = import.meta.env.VITE_API_URL || 'http://localhost:4000'

let refreshPromise = null

function getToken() {
  return localStorage.getItem('token')
}

function authHeaders() {
  const token = getToken()
  const h = { 'Content-Type': 'application/json' }
  if (token) h.Authorization = `Bearer ${token}`
  return h
}

async function tryRefreshToken() {
  const token = getToken()
  if (!token) return null

  if (refreshPromise) return refreshPromise

  refreshPromise = (async () => {
    try {
      const res = await fetch(`${API_BASE}/api/auth/accounts/refresh`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`,
        },
      })

      if (!res.ok) return null

      const data = await res.json().catch(() => null)
      const newToken = data && data.token
      if (!newToken) return null

      localStorage.setItem('token', newToken)
      return newToken
    } catch (e) {
      return null
    } finally {
      refreshPromise = null
    }
  })()

  return refreshPromise
}

async function request(path, opts = {}) {
  const url = `${API_BASE}${path}`
  const res = await fetch(url, opts)
  const text = await res.text().catch(() => '')
  // try to parse JSON when response looks like JSON, otherwise keep raw text
  let data = null
  const contentType = res.headers.get('content-type') || ''
  if (text && contentType.includes('application/json')) {
    try {
      data = JSON.parse(text)
    } catch (e) {
      // parsing failed, leave data null and fall through
      data = null
    }
  } else if (text) {
    data = text
  }

  if (!res.ok) {
    // Ensure we throw an object (not a primitive string/html)
    let errObj
    if (data && typeof data === 'object') {
      errObj = data
    } else {
      errObj = { message: data || res.statusText }
    }

    // Retry once on expired/invalid token by refreshing the session token.
    if (res.status === 401 && !opts._retried) {
      const refreshedToken = await tryRefreshToken()
      if (refreshedToken) {
        const retryHeaders = { ...(opts.headers || {}) }
        retryHeaders.Authorization = `Bearer ${refreshedToken}`
        return request(path, { ...opts, headers: retryHeaders, _retried: true })
      }

      // No valid session anymore: clear stale auth cache.
      localStorage.removeItem('token')
      localStorage.removeItem('user')
    }

    // include status for callers
    errObj.status = errObj.status || res.status
    throw errObj
  }

  return data
}

export { API_BASE, getToken, authHeaders, request }
