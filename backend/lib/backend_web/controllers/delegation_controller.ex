defmodule BackendWeb.DelegationController do
  use BackendWeb, :controller
  require Logger

  alias Backend.Accounts
  alias Backend.Accounts.Etudiant
  alias Backend.Repo

  action_fallback(BackendWeb.FallbackController)

  def designate(conn, params) do
    Logger.debug("[DelegationController.designate] received params: #{inspect(params)}")

    etudiant_id = params["etudiant_id"]
    delegue = params["delegue"]

    unless etudiant_id && delegue !== nil do
      Logger.error(
        "[DelegationController] missing required params: etudiant_id=#{inspect(etudiant_id)}, delegue=#{inspect(delegue)}"
      )

      conn
      |> put_status(:bad_request)
      |> json(%{error: "Missing required parameters: etudiant_id and delegue"})
    else
      designate_delegate(conn, etudiant_id, delegue)
    end
  end

  defp designate_delegate(conn, etudiant_id, delegue) do
    # Accept either an Etudiant id or a Utilisateur id (utilisateur -> etudiant)
    id =
      case etudiant_id do
        v when is_binary(v) -> String.to_integer(v)
        v -> v
      end

    etudiant =
      try do
        Accounts.get_etudiant!(id)
      rescue
        Ecto.NoResultsError ->
          # try to find by utilisateur_id
          Accounts.get_etudiant_by_utilisateur_id(id)
      end

    case etudiant do
      nil ->
        Logger.debug("[DelegationController] no etudiant found for id=#{inspect(id)}")

        conn
        |> put_status(:not_found)
        |> json(%{error: "Etudiant not found for id #{inspect(id)}"})

      %Etudiant{} = e ->
        # Update only the delegation flag without running the full changeset that requires other fields
        changeset = Ecto.Changeset.change(e, %{est_delegue_etudiant: delegue})

        case Repo.update(changeset) do
          {:ok, %Etudiant{} = updated} ->
            Logger.debug(
              "[DelegationController] updated etudiant=#{inspect(updated.id)} est_delegue=#{inspect(updated.est_delegue_etudiant)}"
            )

            # Also update the associated Utilisateur role to 'delegue' when est_delegue_etudiant is true,
            # or revert to 'etudiant' when false.
            try do
              utilisateur = Accounts.get_utilisateur!(updated.utilisateur_id)

              role_name = if updated.est_delegue_etudiant, do: "delegue", else: "etudiant"

              role =
                case Accounts.get_role_by_name(role_name) do
                  nil ->
                    case Accounts.create_role(%{nom_roles: role_name}) do
                      {:ok, r} -> r
                      _ -> nil
                    end

                  r ->
                    r
                end

              if role do
                # update utilisateur role_id; ignore result but log if error
                case Accounts.update_utilisateur(utilisateur, %{"role_id" => role.id}) do
                  {:ok, _u} ->
                    Logger.debug(
                      "[DelegationController] utilisateur=#{utilisateur.id} role set to #{role_name}"
                    )

                  {:error, changeset} ->
                    Logger.error(
                      "[DelegationController] failed updating utilisateur role: #{inspect(changeset.errors)}"
                    )
                end
              else
                Logger.error(
                  "[DelegationController] role #{role_name} not found and could not be created"
                )
              end
            rescue
              _ ->
                Logger.error(
                  "[DelegationController] failed to fetch/update utilisateur for etudiant=#{inspect(updated.id)}"
                )
            end

            json(conn, %{
              data: %{
                etudiant_id: updated.id,
                est_delegue_etudiant: updated.est_delegue_etudiant,
                message: "Statut delegue mis a jour"
              }
            })

          {:error, changeset} ->
            Logger.error(
              "[DelegationController] failed to update etudiant=#{inspect(e.id)}: #{inspect(changeset.errors)}"
            )

            conn
            |> put_status(:unprocessable_entity)
            |> json(%{error: "Failed to update etudiant", details: changeset.errors})
        end
    end
  end
end
