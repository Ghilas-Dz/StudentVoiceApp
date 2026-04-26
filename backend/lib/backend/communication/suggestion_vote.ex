defmodule Backend.Communication.SuggestionVote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "suggestion_votes" do
    field :vote_type, :string

    belongs_to :utilisateur, Backend.Accounts.Utilisateur
    belongs_to :souggestion, Backend.Communication.Souggestion

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [:vote_type, :utilisateur_id, :souggestion_id])
    |> validate_required([:vote_type, :utilisateur_id, :souggestion_id])
    |> validate_inclusion(:vote_type, ["like", "dislike"])
    |> unique_constraint([:utilisateur_id, :souggestion_id])
    |> foreign_key_constraint(:utilisateur_id)
    |> foreign_key_constraint(:souggestion_id)
  end
end
