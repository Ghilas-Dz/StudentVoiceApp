defmodule BackendWeb.Auth.RequireRole do
  @moduledoc """
  Ensures the authenticated account has one of the allowed roles.
  """

  alias BackendWeb.Auth.ErrorResponse

  def init(allowed_roles) when is_list(allowed_roles), do: allowed_roles

  def call(conn, allowed_roles) do
    current_role =
      conn.assigns[:account]
      |> case do
        %{role: %{nom_roles: role}} when is_binary(role) -> normalize(role)
        _ -> nil
      end

    allowed = Enum.map(allowed_roles, &normalize/1)

    if current_role in allowed do
      conn
    else
      raise(ErrorResponse.Forbidden)
    end
  end

  defp normalize(role) when is_binary(role) do
    role
    |> String.normalize(:nfd)
    |> String.replace(~r/\p{Mn}/u, "")
    |> String.downcase()
    |> String.trim()
    |> canonical_role()
  end

  defp canonical_role("enseignant"), do: "professeur"
  defp canonical_role("teacher"), do: "professeur"
  defp canonical_role("prof"), do: "professeur"
  defp canonical_role("administrateur"), do: "admin"
  defp canonical_role("administrator"), do: "admin"
  defp canonical_role("etudiant"), do: "etudiant"
  defp canonical_role("delegue"), do: "delegue"
  defp canonical_role(role), do: role
end
