defmodule Backend.Repo.Migrations.AddCategoryToSouggestions do
  use Ecto.Migration

  def change do
    alter table(:souggestions) do
      add :category, :string, default: "Général"
    end
  end
end
