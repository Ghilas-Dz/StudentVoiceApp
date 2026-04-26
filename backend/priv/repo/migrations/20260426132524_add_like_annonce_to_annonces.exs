defmodule Backend.Repo.Migrations.AddLikeAnnonceToAnnonces do
  use Ecto.Migration

  def up do
    alter table(:annonces) do
      add(:like_annonce, :integer, default: 0, null: false)
    end

    execute("UPDATE annonces SET like_annonce = 0 WHERE like_annonce IS NULL")
  end

  def down do
    alter table(:annonces) do
      remove(:like_annonce)
    end
  end
end
