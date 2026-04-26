defmodule Backend.Repo.Migrations.AddAvancementPourcentageToModule do
  use Ecto.Migration

  def change do
    alter table(:module) do
      add :avancement_pourcentage, :integer, default: 0
    end
  end
end
