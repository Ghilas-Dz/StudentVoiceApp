defmodule Backend.Repo.Migrations.CreateGrades do
  use Ecto.Migration

  def change do
    create table(:grades) do
      add(:note_td_tp, :decimal, precision: 5, scale: 2, null: false)
      add(:note_examen, :decimal, precision: 5, scale: 2, null: false)
      add(:etudiant_id, references(:etudiants, on_delete: :delete_all), null: false)
      add(:module_id, references(:module, on_delete: :delete_all), null: false)
      add(:professeur_id, references(:professeurs, on_delete: :restrict), null: false)

      timestamps(type: :utc_datetime)
    end

    create(index(:grades, [:etudiant_id]))
    create(index(:grades, [:module_id]))
    create(index(:grades, [:professeur_id]))
    create(unique_index(:grades, [:etudiant_id, :module_id, :professeur_id]))
  end
end
