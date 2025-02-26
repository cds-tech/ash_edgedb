defmodule AshEdgeDB.TestRepo.Migrations.MigrateResources2 do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_edgedb.generate_migrations`
  """

  use Ecto.Migration

  def up do
    alter table(:authors) do
      add :badges, {:array, :text}
    end
  end

  def down do
    alter table(:authors) do
      remove :badges
    end
  end
end
