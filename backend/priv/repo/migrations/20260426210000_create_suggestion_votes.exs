defmodule Backend.Repo.Migrations.CreateSuggestionVotes do
  use Ecto.Migration

  def change do
    create table(:suggestion_votes) do
      add :vote_type, :string, null: false
      add :utilisateur_id, references(:utilisateurs, on_delete: :delete_all), null: false
      add :souggestion_id, references(:souggestions, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:suggestion_votes, [:utilisateur_id, :souggestion_id])
    create index(:suggestion_votes, [:souggestion_id])
  end
end
