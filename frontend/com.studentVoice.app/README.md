# EduDeck - Vue 3 (Composition API)

Conversion React TSX → Vue 3 avec `<script setup>` et Composition API.

## Stack
- **Vue 3** avec `<script setup>` (Composition API)
- **TypeScript**
- **Tailwind CSS v3**
- **lucide-vue-next** (équivalent de lucide-react)
- **vue-chartjs + chart.js** (équivalent de recharts)

## Installation

```bash
npm install
```

## Développement

```bash
npm run dev
```

## Build

```bash
npm run build
```

## Structure

```
src/
├── App.vue                          # Composant racine (routing par état)
├── main.ts                          # Point d'entrée
├── styles/
│   ├── index.css                    # Import Tailwind + thème
│   ├── theme.css                    # Variables CSS (inchangées)
│   └── fonts.css                    # Polices (inchangées)
└── components/
    ├── Sidebar.vue                  # Navigation latérale
    ├── Header.vue                   # Barre supérieure
    ├── StatsCards.vue               # Cartes de statistiques
    ├── StudentPerformance.vue       # Graphique en barres (vue-chartjs)
    ├── CourseProgress.vue           # Graphique SVG circulaire
    ├── RecentTickets.vue            # Liste des tickets
    ├── AnnouncementPanel.vue        # Panneau d'annonces
    └── pages/
        ├── Dashboard.vue            # Page tableau de bord
        ├── CoursesList.vue          # Page liste des cours
        ├── StudentsList.vue         # Page liste des étudiants
        └── GradeManagement.vue      # Page gestion des notes
```

## Correspondances React → Vue

| React                     | Vue 3                          |
|---------------------------|--------------------------------|
| `useState`                | `ref()` / `reactive()`         |
| `useMemo` / calcul dérivé | `computed()`                   |
| `props`                   | `defineProps<{}>()`            |
| `emit` (callback prop)    | `defineEmits<{}>()` + `$emit`  |
| `onClick`                 | `@click`                       |
| `onChange`                | `@input` / `v-model`           |
| `onSubmit`                | `@submit.prevent`              |
| JSX conditionnel          | `v-if` / `v-else-if` / `v-else`|
| `.map()` en JSX           | `v-for`                        |
| `className`               | `class` / `:class`             |
| `style={{ width: x }}`   | `:style="{ width: x }"`        |
| Composant dynamique       | `<component :is="..." />`      |
| `lucide-react`            | `lucide-vue-next`              |
| `recharts`                | `vue-chartjs` + `chart.js`     |
