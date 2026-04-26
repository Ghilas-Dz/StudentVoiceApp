defmodule Backend.Repo.Migrations.CreateChapter do
  use Ecto.Migration

  def change do
    create table(:chapter) do
      add(:title, :string, null: false)
      add(:date, :date)
      add(:module_id, references(:module, on_delete: :delete_all), null: false)
      add(:professeur_id, references(:professeurs, on_delete: :delete_all), null: false)

      timestamps(type: :utc_datetime)
    end

    create(index(:chapter, [:module_id]))
    create(index(:chapter, [:professeur_id]))
  end
end
