defmodule Backend.Repo.Migrations.CreateGroupesModules do
  use Ecto.Migration

  def change do
    create table(:groupes_modules, primary_key: false) do
      add :groupe_id, references(:groupes, on_delete: :delete_all), null: false
      add :module_id, references(:module, on_delete: :delete_all), null: false
    end

    create unique_index(:groupes_modules, [:groupe_id, :module_id])
    create index(:groupes_modules, [:module_id])
  end
end
