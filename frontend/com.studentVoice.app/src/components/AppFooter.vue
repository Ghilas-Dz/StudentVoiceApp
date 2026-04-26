<template>
  <footer class="footer">
    <div class="footer-grid">
      <div class="footer-brand sr-item sr-item-1">
        <h3>Portail StudentVoice</h3>
        <p>Votre espace numérique dédié à la gestion de vos demandes académiques. Simple, sécurisé et efficace.</p>
        <div class="footer-socials">
          <a class="social-btn" :href="social.href" target="_blank" rel="noopener noreferrer" :title="social.label" v-for="social in socials" :key="social.label">
            <component :is="social.icon" :size="18" />
          </a>
        </div>
      </div>

      <div class="footer-col">
        <h4>Navigation</h4>
        <ul>
          <li v-for="link in navLinks" :key="link.label">
            <a :href="link.href">{{ link.label }}</a>
          </li>
        </ul>
      </div>

      <div class="footer-col">
        <h4>Ressources</h4>
        <ul>
          <li v-for="link in resourceLinks" :key="link.label">
            <a :href="link.href">{{ link.label }}</a>
          </li>
        </ul>
      </div>

      <div class="footer-col">
        <h4>Contact</h4>
        <div class="footer-contact">
          <div class="contact-item" v-for="item in contactItems" :key="item.icon">
            <component :is="item.icon" :size="18" class="ci" />
            <p v-html="item.text"></p>
          </div>
        </div>
      </div>
    </div>

    <div class="footer-bottom">
      <p>© 2026 Université Abderrahmane-Mira de Béjaïa. Tous droits réservés.</p>
      <span class="footer-badge"><Lock :size="11.5" color="white" /> Plateforme sécurisée</span>
    </div>
  </footer>
</template>

<script setup>
import { Send, Linkedin, Facebook, BookOpen, MapPin, Phone, Mail, Clock, Lock } from 'lucide-vue-next'

const socials = [
  { label: 'X (Twitter)', icon: Send, href: 'https://x.com/U_BEJAIA'},
  { label: 'LinkedIn', icon: Linkedin , href: 'https://fr.linkedin.com/company/universit%C3%A9-de-b%C3%A9jaia' },
  { label: 'Facebook', icon: Facebook, href: 'https://www.facebook.com/Universite.A.M.Bejaia/' },
  { label: 'E-Learning', icon: BookOpen , href: 'https://elearning.univ-bejaia.dz/' }
]

const navLinks = [
  { label: 'Accueil', href: '#hero' },
  { label: 'À Propos', href: '#about' },
  { label: 'Soumettre une demande', href: '#' },
  { label: 'Suivre mon dossier', href: '#' },
  { label: 'FAQ', href: '#' }
]

const resourceLinks = [
  { label: "Guide d'utilisation", href: '#' },
  { label: 'Règlement intérieur', href: '#' },
  { label: 'Formulaires', href: '#' },
  { label: 'Calendrier académique', href: '#' },
  { label: 'Politique de confidentialité', href: '#' }
]

const contactItems = [
  { icon: MapPin, text: 'Route de Targa Ouzemour, 06000 Béjaïa.' },
  { icon: Phone, text: '+213 34-81-68-19<br>+213 34-81-68-20' },
  { icon: Mail, text: 'support.messagerie@univ-bejaia.dz' },
  { icon: Clock, text: 'Dim – jeu : 7h00 – 16h30' }
]
</script>

<style scoped>
.footer {
  background: #0f172a;
  color: var(--white);
  padding: 64px 40px 0;
}

.footer-grid {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1.5fr;
  gap: 40px;
  max-width: 1100px;
  margin: 0 auto;
  padding-bottom: 48px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.08);
}

.footer-brand h3 {
  font-family: 'Playfair Display', serif;
  font-size: 18px;
  color: var(--white);
  margin-bottom: 12px;
}

.footer-brand p {
  font-size: 13px;
  color: rgba(255, 255, 255, 0.5);
  line-height: 1.7;
  margin-bottom: 20px;
}

.footer-socials {
  display: flex;
  gap: 10px;
}

.social-btn {
  width: 36px;
  height: 36px;
  border-radius: 8px;
  background: rgba(255, 255, 255, 0.08);
  border: 1px solid rgba(255, 255, 255, 0.1);
  display: flex;
  align-items: center;
  justify-content: center;
  color: rgba(255, 255, 255, 0.6);
  font-size: 14px;
  cursor: pointer;
  transition: var(--transition);
  text-decoration: none;
}

.social-btn:hover {
  background: var(--blue);
  border-color: var(--blue);
  color: var(--white);
  transform: translateY(-2px);
}

.footer-col h4 {
  font-size: 13px;
  font-weight: 700;
  color: rgba(255, 255, 255, 0.9);
  text-transform: uppercase;
  letter-spacing: 0.8px;
  margin-bottom: 16px;
}

.footer-col ul {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 9px;
}

.footer-col li a {
  font-size: 13px;
  color: rgba(255, 255, 255, 0.45);
  text-decoration: none;
  transition: color var(--transition);
}

.footer-col li a:hover {
  color: #93c5fd;
}

.footer-contact {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.contact-item {
  display: flex;
  align-items: flex-start;
  gap: 10px;
}

.contact-item .ci {
  font-size: 15px;
  flex-shrink: 0;
  margin-top: 1px;
  color: var(--blue);
  display: flex;
  align-items: center;
}

.contact-item p {
  font-size: 12.5px;
  color: rgba(255, 255, 255, 0.45);
  line-height: 1.5;
  margin: 0;
}

.footer-bottom {
  max-width: 1100px;
  margin: 0 auto;
  padding: 20px 0;
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 8px;
}

.footer-bottom p {
  font-size: 12px;
  color: rgba(255, 255, 255, 0.3);
  margin: 0;
}

.footer-badge {
  background: rgba(37, 99, 235, 0.25);
  border: 1px solid rgba(37, 99, 235, 0.4);
  border-radius: 20px;
  padding: 4px 12px;
  font-size: 11px;
  color: #93c5fd;
}

@media (max-width: 1024px) {
  .footer-grid {
    grid-template-columns: 1fr 1fr;
  }
}

@media (max-width: 540px) {
  .footer-grid {
    grid-template-columns: 1fr;
  }
}
</style>
