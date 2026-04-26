defmodule Backend.Repo.Migrations.AddTypeToAnnonces do
  use Ecto.Migration

  def up do
    alter table(:annonces) do
      add(:type_annonce, :string, default: "Pédagogique")
    end

    # Update existing annonces to have default type
    execute("UPDATE annonces SET type_annonce = 'Pédagogique' WHERE type_annonce IS NULL")
  end

  def down do
    alter table(:annonces) do
      remove(:type_annonce)
    end
  end
end
