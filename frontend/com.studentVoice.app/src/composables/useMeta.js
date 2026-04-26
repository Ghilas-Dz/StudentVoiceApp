import { ref } from 'vue'
import { request } from './api'

const meta = ref(null)
let loading = false

export async function loadMeta() {
  if (meta.value || loading) return meta.value
  loading = true
  try {
    const res = await request('/api/meta')
    meta.value = res || {}
    return meta.value
  } catch (e) {
    meta.value = null
    throw e
  } finally {
    loading = false
  }
}

export function useMeta() {
  return { meta, loadMeta }
}
