defmodule AshEdgeDB.TestRepo.Migrations.MigrateResources6 do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_edgedb.generate_migrations`
  """

  use Ecto.Migration

  def up do
    alter table(:post_links) do
      add :state, :text, default: "active"
    end
  end

  def down do
    alter table(:post_links) do
      remove :state
    end
  end
end
