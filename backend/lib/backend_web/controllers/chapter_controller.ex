defmodule BackendWeb.ChapterController do
  use BackendWeb, :controller

  import Ecto.Query, warn: false

  alias Backend.Academics

  action_fallback(BackendWeb.FallbackController)

  def index(conn, %{"module_id" => module_id}) do
    current = conn.assigns.account

    with professeur when not is_nil(professeur) <-
           Backend.Accounts.get_professeur_by_utilisateur_id(current.id) do
      chapters =
        Academics.list_chapters_for_module_and_professeur(
          String.to_integer(module_id),
          professeur.id
        )

      json(conn, %{data: Enum.map(chapters, &chapter_payload/1)})
    else
      nil -> {:error, "Profil professeur introuvable"}
    end
  end

  def create(conn, %{"module_id" => module_id, "title" => title} = params) do
    current = conn.assigns.account

    with professeur when not is_nil(professeur) <-
           Backend.Accounts.get_professeur_by_utilisateur_id(current.id) do
      chapter_params = %{
        title: title,
        date: params["date"],
        module_id: String.to_integer(module_id),
        professeur_id: professeur.id
      }

      with {:ok, chapter} <- Academics.create_chapter(chapter_params) do
        json(conn, %{data: chapter_payload(chapter), message: "Chapitre créé avec succès"})
      end
    else
      nil -> {:error, "Profil professeur introuvable"}
    end
  end

  def show(conn, %{"id" => id}) do
    chapter = Academics.get_chapter!(id)
    json(conn, %{data: chapter_payload(chapter)})
  end

  def update(conn, %{"id" => id} = params) do
    chapter = Academics.get_chapter!(id)
    chapter_params = Map.take(params, ["title", "date"])

    with {:ok, updated_chapter} <- Academics.update_chapter(chapter, chapter_params) do
      json(conn, %{data: chapter_payload(updated_chapter), message: "Chapitre mis à jour"})
    end
  end

  def delete(conn, %{"id" => id}) do
    chapter = Academics.get_chapter!(id)

    with {:ok, _chapter} <- Academics.delete_chapter(chapter) do
      json(conn, %{message: "Chapitre supprimé avec succès"})
    end
  end

  defp chapter_payload(chapter) do
    %{
      id: chapter.id,
      title: chapter.title,
      date: chapter.date,
      module_id: chapter.module_id,
      professeur_id: chapter.professeur_id,
      inserted_at: chapter.inserted_at
    }
  end
end
