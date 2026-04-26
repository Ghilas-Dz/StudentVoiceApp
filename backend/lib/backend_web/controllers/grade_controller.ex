defmodule BackendWeb.GradeController do
  use BackendWeb, :controller

  import Ecto.Query, warn: false

  alias Backend.Academics
  alias Backend.Academics.Grade
  alias Backend.Accounts
  alias Backend.Repo

  action_fallback(BackendWeb.FallbackController)

  @doc """
  List all grades for the current professor
  """
  def index(conn, _params) do
    current = conn.assigns.account

    with professeur when not is_nil(professeur) <-
           Accounts.get_professeur_by_utilisateur_id(current.id) do
      grades = Academics.list_grades_for_professeur(professeur.id)
      json(conn, %{data: grade_payload_list(grades)})
    else
      nil -> {:error, "Profil professeur introuvable"}
    end
  end

  @doc """
  List grades for a specific module
  """
  def list_by_module(conn, %{"module_id" => module_id}) do
    current = conn.assigns.account

    with professeur when not is_nil(professeur) <-
           Accounts.get_professeur_by_utilisateur_id(current.id) do
      grades = Academics.list_grades_for_module(module_id, professeur.id)
      json(conn, %{data: grade_payload_list(grades)})
    else
      nil -> {:error, "Profil professeur introuvable"}
    end
  end

  @doc """
  Create a new grade
  """
  def create(conn, %{"grade" => grade_params}) do
    current = conn.assigns.account

    with professeur when not is_nil(professeur) <-
           Accounts.get_professeur_by_utilisateur_id(current.id) do
      attrs = Map.put(grade_params, "professeur_id", professeur.id)

      with {:ok, %Grade{} = grade} <- Academics.create_grade(attrs) do
        grade = Repo.preload(grade, [etudiant: :utilisateur, module: [], professeur: :utilisateur])

        conn
        |> put_status(:created)
        |> json(%{data: grade_payload(grade)})
      end
    else
      nil -> {:error, "Profil professeur introuvable"}
    end
  end

  @doc """
  Get a specific grade
  """
  def show(conn, %{"id" => id}) do
    grade = Academics.get_grade!(id)
    json(conn, %{data: grade_payload(grade)})
  end

  @doc """
  Update a grade
  """
  def update(conn, %{"id" => id, "grade" => grade_params}) do
    grade = Academics.get_grade!(id)

    with {:ok, %Grade{} = updated_grade} <- Academics.update_grade(grade, grade_params) do
      updated_grade = Repo.preload(updated_grade, [etudiant: :utilisateur, module: [], professeur: :utilisateur])
      json(conn, %{data: grade_payload(updated_grade)})
    end
  end

  @doc """
  Delete a grade
  """
  def delete(conn, %{"id" => id}) do
    grade = Academics.get_grade!(id)

    with {:ok, _} <- Academics.delete_grade(grade) do
      send_resp(conn, :no_content, "")
    end
  end

  # Private helper functions

  defp grade_payload(grade) do
    %{
      id: grade.id,
      note_td_tp: Decimal.to_float(grade.note_td_tp),
      note_examen: Decimal.to_float(grade.note_examen),
      etudiant: %{
        id: grade.etudiant.id,
        name:
          "#{grade.etudiant.utilisateur.prenom_utilisateurs} #{grade.etudiant.utilisateur.nom_utilisateurs}",
        email: grade.etudiant.utilisateur.email_utilisateurs
      },
      module: %{
        id: grade.module.id,
        code: grade.module.code_cours,
        name: grade.module.intitule_cours
      },
      professeur_id: grade.professeur_id,
      inserted_at: grade.inserted_at
    }
  end

  defp grade_payload_list(grades) do
    Enum.map(grades, &grade_payload/1)
  end
end
