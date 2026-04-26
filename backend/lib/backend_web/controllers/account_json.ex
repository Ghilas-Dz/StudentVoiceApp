defmodule BackendWeb.AccountJSON do
  def show(%{utilisateur: utilisateur, token: token}) do
    %{
      id: utilisateur.id,
      email_utilisateurs: utilisateur.email_utilisateurs,
      prenom_utilisateurs: utilisateur.prenom_utilisateurs,
      nom_utilisateurs: utilisateur.nom_utilisateurs,
      avatar_utilisateurs: utilisateur.avatar_utilisateurs,
      role: utilisateur.role.nom_roles,
      token: token
    }
  end

  def show_update(%{utilisateur: utilisateur}) do
    %{
      id: utilisateur.id,
      email_utilisateurs: utilisateur.email_utilisateurs,
      prenom_utilisateurs: utilisateur.prenom_utilisateurs,
      nom_utilisateurs: utilisateur.nom_utilisateurs,
      avatar_utilisateurs: utilisateur.avatar_utilisateurs
    }
  end

  def profile(%{utilisateur: utilisateur}) do
    %{
      utilisateur: %{
        id: utilisateur.id,
        email_utilisateurs: utilisateur.email_utilisateurs,
        prenom_utilisateurs: utilisateur.prenom_utilisateurs,
        nom_utilisateurs: utilisateur.nom_utilisateurs,
        avatar_utilisateurs: utilisateur.avatar_utilisateurs,
        role: utilisateur.role.nom_roles,
        etudiant:
          if utilisateur.etudiant do
            %{
              id: utilisateur.etudiant.id,
              est_delegue_etudiant: utilisateur.etudiant.est_delegue_etudiant,
              date_naissance_etudiant: utilisateur.etudiant.date_naissance_etudiant,
              telephone_etudiant: utilisateur.etudiant.telephone_etudiant,
              groupe_id: utilisateur.etudiant.groupe_id,
              groupe:
                utilisateur.etudiant.groupe &&
                  %{
                    id: utilisateur.etudiant.groupe.id,
                    code: utilisateur.etudiant.groupe.code_groupes,
                    libele: utilisateur.etudiant.groupe.libele_groupes,
                    niveau: utilisateur.etudiant.groupe.niveau_groupe,
                    filiere: utilisateur.etudiant.groupe.filier_groupe
                  }
            }
          else
            nil
          end,
        professeur:
          if utilisateur.professeur do
            %{
              id: utilisateur.professeur.id,
              grade: utilisateur.professeur.grade_professeurs,
              specialite: utilisateur.professeur.specialite_professeurs,
              telephone: utilisateur.professeur.telephone_professeurs
            }
          else
            nil
          end
      }
    }
  end
end
