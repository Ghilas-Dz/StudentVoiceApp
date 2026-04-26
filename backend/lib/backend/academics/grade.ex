defmodule Backend.Academics.Grade do
  use Ecto.Schema
  import Ecto.Changeset

  schema "grades" do
    field(:note_td_tp, :decimal)
    field(:note_examen, :decimal)

    belongs_to(:etudiant, Backend.Accounts.Etudiant)
    belongs_to(:module, Backend.Academics.Module)
    belongs_to(:professeur, Backend.Accounts.Professeur)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(grade, attrs) do
    grade
    |> cast(attrs, [:note_td_tp, :note_examen, :etudiant_id, :module_id, :professeur_id])
    |> validate_required([:note_td_tp, :note_examen, :etudiant_id, :module_id, :professeur_id])
    |> validate_number(:note_td_tp, greater_than_or_equal_to: 0, less_than_or_equal_to: 20)
    |> validate_number(:note_examen, greater_than_or_equal_to: 0, less_than_or_equal_to: 20)
    |> foreign_key_constraint(:etudiant_id)
    |> foreign_key_constraint(:module_id)
    |> foreign_key_constraint(:professeur_id)
    |> unique_constraint([:etudiant_id, :module_id, :professeur_id])
  end
end
