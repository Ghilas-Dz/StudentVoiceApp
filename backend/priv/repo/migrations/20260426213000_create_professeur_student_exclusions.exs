defmodule Backend.Repo.Migrations.CreateProfesseurStudentExclusions do
  use Ecto.Migration

  def change do
    create table(:professeur_student_exclusions) do
      add :professeur_id, references(:professeurs, on_delete: :delete_all), null: false
      add :etudiant_id, references(:etudiants, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:professeur_student_exclusions, [:professeur_id, :etudiant_id])
    create index(:professeur_student_exclusions, [:etudiant_id])
  end
end
