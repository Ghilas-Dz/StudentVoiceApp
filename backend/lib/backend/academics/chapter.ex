defmodule Backend.Academics.Chapter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chapter" do
    field(:title, :string)
    field(:date, :date)

    belongs_to(:module, Backend.Academics.Module)
    belongs_to(:professeur, Backend.Accounts.Professeur)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(chapter, attrs) do
    chapter
    |> cast(attrs, [:title, :date, :module_id, :professeur_id])
    |> validate_required([:title, :module_id, :professeur_id])
  end
end
