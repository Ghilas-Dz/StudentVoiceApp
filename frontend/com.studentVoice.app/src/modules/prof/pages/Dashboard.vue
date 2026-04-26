<template>
  <div class="flex flex-col lg:flex-row gap-6 h-full" style="--blue: #255fe3; --blue-dark: #1f54d2; --blue-deep: #1d3f95">
    <!-- Left Column -->
    <div class="flex-1 flex flex-col gap-6 min-w-0">
      <!-- Stats Cards -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
        <div
          v-for="(stat, index) in stats"
          :key="index"
          :class="[
            'relative rounded-2xl p-6',
            stat.color === 'indigo'
              ? 'text-white shadow-xl shadow-indigo-600/30 total-reclamations-bg'
              : 'bg-white border border-gray-200'
          ]"
        >
          <div class="flex items-start justify-between mb-4">
            <div
              :class="[
                'p-3 rounded-xl',
                stat.color === 'indigo' ? 'bg-white/10' : 'bg-gray-100'
              ]"
            >
              <component
                :is="stat.icon"
                :class="[
                  'w-6 h-6',
                  stat.color === 'indigo' ? 'text-white' : 'text-gray-600'
                ]"
              />
            </div>
            <span
              :class="[
                'px-3 py-1 rounded-full text-xs font-semibold',
                stat.changeType === 'positive'
                  ? 'bg-green-500 text-white'
                  : 'bg-red-500 text-white'
              ]"
            >
              {{ stat.change }}
            </span>
          </div>

          <div>
            <p
              :class="[
                'text-sm font-medium mb-2',
                stat.color === 'indigo' ? 'text-white/80' : 'text-gray-600'
              ]"
            >
              {{ stat.title }}
            </p>
            <h3
              :class="[
                'text-3xl font-bold mb-1',
                stat.color === 'indigo' ? 'text-white' : 'text-gray-900'
              ]"
            >
              {{ stat.value }}
            </h3>
            <p
              :class="[
                'text-xs',
                stat.color === 'indigo' ? 'text-white/60' : 'text-gray-500'
              ]"
            >
              {{ stat.subtitle }}
            </p>
          </div>
        </div>
      </div>

 
      <!-- Recent Tickets -->
      <div class="bg-white rounded-2xl p-6 border border-gray-200">
        <div class="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 mb-6">
          <div>
            <h2 class="text-xl font-bold text-gray-900">Tickets Récents</h2>
            <p class="text-sm text-gray-500 mt-1">Questions et demandes des étudiants</p>
          </div>

          <RouterLink
            to="/prof/tickets"
            class="px-4 py-2 text-white rounded-lg text-sm hover:bg-gray-100 dark:hover:bg-var(--hover) "
            style="background: linear-gradient(135deg, var(--blue-dark) 0%, var(--blue) 50%, var(--blue-deep) 100%); --blue: #255fe3; --blue-dark: #1f54d2; --blue-deep: #1d3f95; font-weight: 600"
          >
            Voir tout
          </RouterLink>
        </div>

        <div class="space-y-3">
          <div
            v-for="ticket in tickets"
            :key="ticket.id"
            :class="[
              'p-4 rounded-xl border-l-4 bg-gray-50 hover:bg-gray-100 transition-colors cursor-pointer',
              getPriorityColor(ticket.priority)
            ]"
          >
            <div class="flex items-start justify-between">
              <div class="flex-1">
                <div class="flex items-center gap-2 mb-2">
                  <span class="text-xs font-semibold text-indigo-600">{{ ticket.id }}</span>
                  <span class="text-xs text-gray-400">•</span>
                  <span class="text-xs text-gray-600">{{ ticket.student }}</span>
                  <span class="text-xs text-gray-400">•</span>
                  <span class="text-xs text-gray-500">{{ ticket.course }}</span>
                </div>
                <h4 class="font-semibold text-gray-900 mb-2">{{ ticket.subject }}</h4>
                <div class="flex items-center gap-2">
                  <span
                    :class="[
                      'inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium',
                      getStatusColor(ticket.status)
                    ]"
                  >
                    <component :is="getStatusIcon(ticket.status)" class="w-3 h-3" />
                    <span v-if="ticket.status === 'en-attente'">En attente</span>
                    <span v-else-if="ticket.status === 'en-cours'">En cours</span>
                    <span v-else-if="ticket.status === 'resolu'">Résolu</span>
                  </span>
                  <span class="text-xs text-gray-500">Il y a {{ ticket.time }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Right Column -->
    <div class="w-full lg:w-[380px] flex-shrink-0 flex flex-col gap-6">
      <!-- Course Progress -->
      <div class="bg-white rounded-2xl p-6 border border-gray-200">
        <div class="text-center mb-6">
          <h2 class="text-xl font-bold text-gray-900">Statistiques Cours</h2>
          <p class="text-sm text-gray-500 mt-1">Suivez vos inscriptions</p>
        </div>

        <div class="flex flex-col items-center mb-4">
          <div class="px-4 py-2 bg-gray-50 rounded-full border border-gray-100 flex items-center gap-2 shadow-sm">
            <span class="text-xs text-gray-500 uppercase tracking-widest font-bold">Total Inscrits</span>
            <span class="text-xl font-black text-blue-600">105</span>
          </div>
        </div>

        <div class="flex items-center justify-center mb-8 relative h-[220px]">
          <svg width="200" height="200" viewBox="0 0 200 200" class="transform -rotate-90">
            <defs>
              <linearGradient id="blueGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" style="stop-color: var(--blue-dark); stop-opacity:1" />
                <stop offset="50%" style="stop-color: var(--blue); stop-opacity:1" />
                <stop offset="100%" style="stop-color: var(--blue-deep); stop-opacity:1" />
              </linearGradient>
              <linearGradient id="redGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" style="stop-color: #c41e1e; stop-opacity:1" />
                <stop offset="50%" style="stop-color: #DC2626; stop-opacity:1" />
                <stop offset="100%" style="stop-color: #a51b1b; stop-opacity:1" />
              </linearGradient>
            </defs>
            <circle cx="100" cy="100" r="85" fill="none" stroke="#e5e7eb" stroke-width="12" />
            <circle cx="100" cy="100" r="70" fill="none" stroke="#e5e7eb" stroke-width="12" />
            <circle cx="100" cy="100" r="55" fill="none" stroke="#e5e7eb" stroke-width="12" />
            <circle
              cx="100"
              cy="100"
              r="85"
              fill="none"
              stroke="url(#blueGradient)"
              stroke-width="12"
              stroke-dasharray="534"
              stroke-dashoffset="133.5"
              stroke-linecap="round"
            />
            <circle
              cx="100"
              cy="100"
              r="70"
              fill="none"
              stroke="url(#blueGradient)"
              stroke-width="12"
              stroke-dasharray="440"
              stroke-dashoffset="176"
              stroke-linecap="round"
            />
            <circle
              cx="100"
              cy="100"
              r="55"
              fill="none"
              stroke="url(#redGradient)"
              stroke-width="12"
              stroke-dasharray="345"
              stroke-dashoffset="86.25"
              stroke-linecap="round"
            />
          </svg>

          <div class="absolute inset-0 flex flex-col items-center justify-center">
            <span class="px-3 py-1 bg-green-500 text-white rounded-full text-xs font-semibold">
              +5,33%
            </span>
          </div>
        </div>

        <div class="space-y-3">
          <div
            v-for="(course, index) in courses"
            :key="index"
            class="flex items-center justify-between"
          >
            <div class="flex items-center gap-3">
              <div
                :class="[
                  'w-2 h-2 rounded-full',
                  course.color === 'indigo' ? 'bg-indigo-600' : 'bg-red-500'
                ]"
              ></div>
              <span class="text-sm font-medium text-gray-900">{{ course.name }}</span>
            </div>
            <div class="flex items-center gap-3">
              <span class="text-lg font-bold text-gray-900">{{ course.students }}</span>
              <span
                :class="[
                  'px-2.5 py-1 rounded-full text-xs font-semibold',
                  course.trend === 'up' ? 'bg-green-500 text-white' : 'bg-red-500 text-white'
                ]"
              >
                {{ course.change }}
              </span>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</template>

<script setup>
import {
  Users,
  BookOpen,
  FileCheck,
  TrendingUp,
  MessageSquare,
  Clock,
  CheckCircle,
  AlertCircle,
} from 'lucide-vue-next'
import { onMounted, ref } from 'vue'
import { professeurModulesProgress } from '../../../composables/useModules'
import { listTicketsForProf, ticketsStats } from '../../../composables/useTickets'

import { RouterLink } from 'vue-router'




const stats = ref([])

const tickets = ref([])

function getStatusColor(status) {
  switch (status) {
    case 'en-attente':
      return 'bg-orange-100 text-orange-700'
    case 'en-cours':
      return 'bg-blue-100 text-blue-700'
    case 'resolu':
      return 'bg-green-100 text-green-700'
    default:
      return 'bg-gray-100 text-gray-700'
  }
}

function getStatusIcon(status) {
  switch (status) {
    case 'en-attente':
      return AlertCircle
    case 'en-cours':
      return Clock
    case 'resolu':
      return CheckCircle
    default:
      return MessageSquare
  }
}

function getPriorityColor(priority) {
  switch (priority) {
    case 'haute':
      return 'border-l-red-500'
    case 'moyenne':
      return 'border-l-yellow-500'
    case 'basse':
      return 'border-l-green-500'
    default:
      return 'border-l-gray-300'
  }
}

const courses = ref([])

onMounted(async () => {
  try {
    const mres = await professeurModulesProgress()
    if (mres && mres.data) {
      courses.value = mres.data.map((r) => ({ name: (r.module && r.module.intitule_cours) || 'Cours', students: r.students_count || 0, change: '', trend: r.avancement_pourcentage >= 50 ? 'up' : 'down', color: 'indigo' }))
    }
  } catch (e) {
    console.debug('professeurModulesProgress error', e)
  }

  try {
    const tres = await listTicketsForProf()
    if (tres && tres.data) tickets.value = tres.data
  } catch (e) {
    console.debug('listTicketsForProf failed', e)
  }

  try {
    const sres = await ticketsStats()
    if (sres && sres.data) {
      stats.value = [
        { icon: Users, title: 'Total Tickets', value: sres.data.total || 0, change: '', changeType: 'positive', subtitle: 'Tickets', color: 'indigo' },
        { icon: BookOpen, title: 'En attente', value: sres.data.en_attente || 0, change: '', changeType: 'positive', subtitle: '', color: 'white' },
        { icon: TrendingUp, title: 'En cours', value: sres.data.en_cours || 0, change: '', changeType: 'negative', subtitle: '', color: 'white' },
        { icon: FileCheck, title: 'Résolus', value: sres.data.acceptee || 0, change: '', changeType: 'positive', subtitle: '', color: 'white' },
      ]
    }
  } catch (e) {
    console.debug('ticketsStats failed', e)
    // keep default empty stats
  }
})
</script>

<style scoped>
.total-reclamations-bg {
  background: linear-gradient(135deg, var(--blue-dark) 0%, var(--blue) 50%, var(--blue-deep) 100%);
}

.legend-resolues {
  background: linear-gradient(135deg, var(--blue-dark) 0%, var(--blue) 50%, var(--blue-deep) 100%);
}
</style>

