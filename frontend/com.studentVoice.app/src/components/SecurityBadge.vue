<template>
  <div
    class="px-8 py-3.5 flex items-center justify-center gap-2"
    :style="{ background: '#f8fafc', borderTop: '1px solid #f1f5f9' }"
  >
    <svg width="13" height="13" viewBox="0 0 24 24" fill="none">
      <path
        d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"
        stroke="#22c55e"
        stroke-width="1.8"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
      <path
        d="M9 12l2 2 4-4"
        stroke="#22c55e"
        stroke-width="1.8"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    <span class="text-xs" :style="{ color: '#94a3b8' }">Connexion sécurisée · SSL/TLS</span>
  </div>
</template>
