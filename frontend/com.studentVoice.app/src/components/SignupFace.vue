<template>
  <div>
    <!-- Banner -->
    <div
      class="relative px-8 pt-7 pb-6 text-center overflow-hidden"
      :style="{ background: bannerGradient, transition: 'background 0.5s ease' }"
    >
      <div
        class="absolute inset-0 opacity-10"
        :style="{
          backgroundImage:
            'radial-gradient(circle at 20% 50%,white 1px,transparent 1px),radial-gradient(circle at 80% 20%,white 1px,transparent 1px)',
          backgroundSize: '40px 40px',
        }"
      />

      <!-- Back button -->
      <button
        type="button"
        @click="$emit('flip')"
        class="absolute top-4 left-5 flex items-center gap-1.5 px-3 py-1.5 rounded-lg transition-all duration-200"
        :style="{
          background: 'rgba(255,255,255,0.18)',
          color: 'white',
          border: '1px solid rgba(255,255,255,0.25)',
          cursor: 'pointer',
          fontSize: '0.78rem',
          fontWeight: 600,
        }"
        @mouseenter="(e) => (e.currentTarget.style.background = 'rgba(255,255,255,0.28)')"
        @mouseleave="(e) => (e.currentTarget.style.background = 'rgba(255,255,255,0.18)')"
      >
        <IconBack /> Retour
      </button>

      <div
        class="relative inline-flex items-center justify-center w-12 h-12 rounded-2xl mb-2 mt-1"
        :style="{
          background: 'rgba(255,255,255,0.18)',
          backdropFilter: 'blur(10px)',
          border: '1px solid rgba(255,255,255,0.25)',
        }"
      >
        <GraduationCap v-if="role === 'etudiant'" :size="24" stroke="white"  />
        <Briefcase v-else-if="role === 'enseignant'" :size="24" stroke="white" />
        <User v-else :size="24" stroke="white" stroke-width="1.8" />
      </div>
      <h1 class="text-white text-lg mb-0.5" :style="{ fontWeight: 700, letterSpacing: '-0.02em' }">Créer un compte</h1>
      <p class="text-white text-xs" :style="{ opacity: 0.8 }">
        {{ role === 'etudiant' ? 'Espace Étudiant' : role === 'enseignant' ? 'Espace Enseignant' : 'Rejoignez votre université' }}
      </p>
    </div>

    <div class="px-7 py-6">
      <div v-if="error" class="rounded-md p-3 text-sm text-red-800 bg-red-50 border border-red-100 mb-3 mx-7">
        {{ error }}
      </div>
      <!-- Role Selector -->
      <div class="mb-5">
        <p class="text-xs uppercase mb-2.5 text-slate-500 font-semibold tracking-[0.07em]">
          Choisissez votre rôle
        </p>
        <div class="grid grid-cols-2 gap-3">
          <RoleCard
            :active="role === 'etudiant'"
            @click="role = 'etudiant'"
            color="#0d9488"
            :icon="IconEtudiant"
            label="Étudiant"
            desc="Accès cours & ressources"
          />
          <RoleCard
            :active="role === 'enseignant'"
            @click="role = 'enseignant'"
            color="#8b5cf6"
            :icon="IconEnseignant"
            label="Enseignant"
            desc="Gestion cours & étudiants"
          />
        </div>
      </div>

      <!-- Dynamic Form -->
      <form v-show="role" @submit.prevent="handleSubmit" class="flex flex-col gap-3.5" :style="{
        opacity: role ? 1 : 0,
        transform: role ? 'translateY(0)' : 'translateY(-8px)',
        transition: 'opacity 0.5s cubic-bezier(0.4, 0, 0.2, 1), transform 0.5s cubic-bezier(0.4, 0, 0.2, 1)',
        pointerEvents: role ? 'auto' : 'none',
        willChange: 'opacity, transform',
      }">
          <!-- Common fields -->
          <div class="grid grid-cols-2 gap-3">
            <Field id="prenom" label="Prénom" v-model="prenom" placeholder="" :icon="IconUser" />
            <Field id="nom" label="Nom" v-model="nom" placeholder="" :icon="IconUser" />
          </div>
          <Field
            id="signup-email"
            label="Adresse email"
            v-model="email"
            placeholder=""
            :icon="IconEmail"
          />

          <!-- Role-specific fields -->
          <template v-if="role === 'etudiant'">
            <Field id="groupe" label="Groupe" v-model="groupe" placeholder="" :icon="IconId" />
            <Field id="dateNaissance" label="Date de naissance" v-model="dateNaissance" type="date" :icon="IconId" />
            <Field id="telephoneEtudiant" label="Téléphone" v-model="telephoneEtudiant" placeholder="Ex: 0550xxxxxx" :icon="IconId" />
          </template>

          <template v-else-if="role === 'enseignant'">
            <Field
              id="grade"
              label="Grade / Spécialité"
              v-model="grade"
              placeholder=""
              :icon="IconStar"
            />
            <Field id="specialite" label="Spécialité" v-model="specialite" placeholder="" :icon="IconStar" />
            <Field id="telephoneProf" label="Téléphone" v-model="telephoneProf" placeholder="Ex: 0550xxxxxx" :icon="IconId" />
          </template>

          <PasswordField id="signup-password" label="Mot de passe" v-model="password" />
          <PasswordField id="confirm-password" label="Confirmer le mot de passe" v-model="confirm" />

          <div v-if="confirm.length > 0" class="flex items-center gap-2 text-xs" :style="{ color: confirm === password ? '#16a34a' : '#dc2626' }">
            <svg v-if="confirm === password" width="13" height="13" viewBox="0 0 24 24" fill="none">
              <path d="M20 6L9 17l-5-5" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" />
            </svg>
            <svg v-else width="13" height="13" viewBox="0 0 24 24" fill="none">
              <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="2" />
              <path d="M12 8v4M12 16h.01" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
            </svg>
            {{ confirm === password ? 'Les mots de passe correspondent' : 'Les mots de passe ne correspondent pas' }}
          </div>

          <div class="pt-1">
            <ActionButton
              :label="role === 'etudiant' ? 'Créer mon compte étudiant' : 'Créer mon compte enseignant'"
              :loading="loading"
              :icon="IconCheck"
              :gradient="btnGradient"
            />
          </div>
      </form>

      <p v-if="!role" class="text-center text-sm py-2" :style="{ color: '#94a3b8' }">
        Sélectionnez un rôle pour continuer
      </p>
    </div>

    <SecurityBadge />
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'
import {
  GraduationCap,
  Briefcase,
  User,
  Mail,
  CreditCard,
  Book,
  Wrench,
  Star,
  Check,
  ArrowLeft,
} from 'lucide-vue-next'
import Field from './Field.vue'
import PasswordField from './PasswordField.vue'
import ActionButton from './ActionButton.vue'
import RoleCard from './RoleCard.vue'
import SecurityBadge from './SecurityBadge.vue'
import { useAuth } from '../composables/useAuth'
import { useRouter } from 'vue-router'

const role = ref(null)
const loading = ref(false)
const prenom = ref('')
const nom = ref('')
const email = ref('')
const password = ref('')
const confirm = ref('')
// removed unused fields: numEtudiant, filiere, departement
const grade = ref('')
const groupe = ref('')
const dateNaissance = ref('')
const telephoneEtudiant = ref('')
const specialite = ref('')
const telephoneProf = ref('')

const bannerGradient = computed(() => {
  if (role.value === 'etudiant') return 'linear-gradient(135deg,#0f7069 0%,#0d9084 60%,#13b3a1 100%)'
  if (role.value === 'enseignant') return 'linear-gradient(135deg,#7640d8 0%,#8557ee 60%,#9f86f5 100%)'
  return 'linear-gradient(135deg,#1f54d2 0%,#255fe3 60%,#3b7af0 100%)'
})

const btnGradient = computed(() => {
  if (role.value === 'etudiant') return 'linear-gradient(135deg,#0d9084,#13b3a1)'
  if (role.value === 'enseignant') return 'linear-gradient(135deg,#7640d8,#8557ee)'
  return undefined
})

const IconEtudiant = GraduationCap
const IconEnseignant = Briefcase
const IconEmail = Mail
const IconUser = User
const IconId = CreditCard
const IconBook = Book
const IconBuild = Wrench
const IconStar = Star
const IconCheck = Check
const IconBack = ArrowLeft

defineEmits([
  'flip'
])

const { register, setUser } = useAuth()
const router = useRouter()

const error = ref('')

const handleSubmit = async () => {
  loading.value = true
  try {
    // Determine selected role from the RoleCard and map to backend role name
    const selectedRole = role.value || 'etudiant'
    const roleName = selectedRole === 'enseignant' ? 'professeur' : 'etudiant'

    // Basic client-side validation
    if (!selectedRole) throw new Error('Veuillez sélectionner un rôle.')
    
    // Name validation: letters, spaces, hyphens
    const nameRegex = /^[A-Za-zÀ-ÿ\s-]+$/;
    if (!prenom.value || !nom.value) throw new Error('Prénom et nom requis.')
    if (!nameRegex.test(prenom.value) || !nameRegex.test(nom.value)) {
      throw new Error('Le prénom et le nom ne doivent contenir que des lettres.')
    }

    // Email validation
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!email.value || !emailRegex.test(email.value)) throw new Error("Une adresse email valide est requise.")
    if (!email.value.endsWith('univ-bejaia.dz')) throw new Error("Utilisez l'adresse universitaire (univ-bejaia.dz).")
    
    // Password validation: minimum 8 characters
    if (!password.value || password.value.length < 8) {
      throw new Error("Mot de passe d'au moins 8 caractères requis.")
    }
    if (password.value !== confirm.value) throw new Error('Les mots de passe ne correspondent pas.')

    // Phone validation (Algerian format roughly: starts with 05/06/07, 10 digits total)
    const phoneRegex = /^0[567][0-9]{8}$/;
    if (selectedRole === 'etudiant') {
      if (telephoneEtudiant.value && !phoneRegex.test(telephoneEtudiant.value.replace(/\s/g, ''))) {
        throw new Error('Le numéro de téléphone étudiant est invalide (ex: 0550123456).')
      }
      if (!dateNaissance.value) throw new Error('La date de naissance est requise.')
    } else if (selectedRole === 'enseignant') {
      if (telephoneProf.value && !phoneRegex.test(telephoneProf.value.replace(/\s/g, ''))) {
        throw new Error('Le numéro de téléphone enseignant est invalide (ex: 0550123456).')
      }
    }

    // Build account payload to match backend expectations
    const account = {
      email_utilisateurs: email.value,
      password: password.value,
      prenom_utilisateurs: prenom.value,
      nom_utilisateurs: nom.value,
      role: roleName,
    }

    if (role.value === 'etudiant') {
      // backend expects groupe, date_naissance_etudiant and telephone
      account.groupe = groupe.value || 'A'
      account.date_naissance_etudiant = dateNaissance.value || '2000-01-01'
      account.telephone_etudiant = telephoneEtudiant.value || ''
    } else if (role.value === 'enseignant') {
      account.grade_professeurs = grade.value || 'Maitre de conférence'
      account.specialite_professeurs = specialite.value || 'Général'
      account.telephone_professeurs = telephoneProf.value || ''
    }

    const user = await register(account, roleName)
    setUser(user)

    // Redirect based on backend role (normalize value)
    const rawRole = (user.role || '').toString()
    const roleNormalized = rawRole
      .normalize('NFD')
      .replace(/\p{Diacritic}/gu, '')
      .toLowerCase()

    try {
      console.debug('Register success:', { user, role: roleNormalized, availableRoutes: router.getRoutes().map(r => r.name || r.path) })
      if (roleNormalized.includes('prof') || roleNormalized.includes('enseign') || roleNormalized.includes('teach')) {
        await router.push('/prof/dashboard')
      } else if (roleNormalized.includes('etu') || roleNormalized.includes('student')) {
        await router.push('/student/dashboard')
      } else if (roleNormalized.includes('admin') || roleNormalized.includes('administration')) {
        await router.push('/admin/dashboard')
      } else if (roleNormalized.includes('deleg')) {
        await router.push('/student/dashboard')
      } else {
        await router.push('/home')
      }
    } catch (e) {
      try { window.location.href = '/' } catch {}
    }
  } catch (err) {
    console.error('Register error', err)
    const message = (err && err.message) || 'Impossible de créer le compte'
    error.value = message
  } finally {
    loading.value = false
  }
}

// clear error when any main field changes
watch([prenom, nom, email, password, confirm, grade, groupe, dateNaissance, telephoneEtudiant, specialite, telephoneProf], () => {
  if (error.value) error.value = ''
})
</script>
