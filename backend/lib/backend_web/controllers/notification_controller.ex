defmodule BackendWeb.NotificationController do
  use BackendWeb, :controller

  import Ecto.Query, warn: false

  alias Backend.Repo
  alias Backend.Support.Notification

  action_fallback(BackendWeb.FallbackController)

  def index(conn, _params) do
    current = conn.assigns.account

    notifications =
      Notification
      |> where([n], n.pour_tous == true or n.utilisateur_id == ^current.id)
      |> order_by([n], desc: n.inserted_at)
      |> Repo.all()

    json(conn, %{data: Enum.map(notifications, &notification_payload/1)})
  end

  defp notification_payload(notification) do
    %{
      id: notification.id,
      type_notifications: notification.type_notifications,
      message_notifications: notification.message_notifications,
      cree_le_notifications: notification.cree_le_notifications,
      lien_notifications: notification.lien_notifications,
      pour_tous: notification.pour_tous,
      ticket_id: notification.ticket_id,
      utilisateur_id: notification.utilisateur_id,
      inserted_at: notification.inserted_at
    }
  end
end
