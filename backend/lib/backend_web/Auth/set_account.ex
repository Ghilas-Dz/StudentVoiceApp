defmodule BackendWeb.Auth.SetAccount do
  import Plug.Conn
  alias BackendWeb.Auth.ErrorResponse
  alias Backend.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    account =
      cond do
        conn.assigns[:account] ->
          conn.assigns[:account]

        account = Guardian.Plug.current_resource(conn) ->
          account

        account_id = get_session(conn, :id) ->
          Accounts.get_utilisateur!(account_id)

        true ->
          raise(ErrorResponse.Unauthorized)
      end

    conn = assign(conn, :account, account)

    # Check if this is an admin route (admin can manage other users)
    is_admin_route = String.starts_with?(conn.request_path, "/api/auth/admin")

    # Skip ownership verification for admin routes
    unless is_admin_route do
      # Vérifier uniquement si la route contient un paramètre indiquant
      # explicitement un identifiant de compte/utilisateur (évite les collisions
      # avec d'autres ressources utilisant `id` comme ticket id)
      user_id_keys = ["account_id", "utilisateur_id", "user_id", "etudiant_id"]

      resource_param = Enum.find(user_id_keys, fn k -> Map.has_key?(conn.params, k) end)

      case resource_param do
        nil ->
          # pas de vérification nécessaire
          conn

        key ->
          resource_id = conn.params[key]

          if to_string(account.id) != to_string(resource_id) do
            raise(ErrorResponse.Unauthorized)
          else
            conn
          end
      end
    else
      conn
    end
  end
end
