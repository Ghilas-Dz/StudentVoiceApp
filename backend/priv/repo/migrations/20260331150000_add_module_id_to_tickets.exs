defmodule Backend.Repo.Migrations.AddModuleIdToTickets do
  use Ecto.Migration

  def change do
    alter table(:tickets) do
      add :module_id, references(:module, on_delete: :nilify_all)
    end

    create index(:tickets, [:module_id])
  end
end
