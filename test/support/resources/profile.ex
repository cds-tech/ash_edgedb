defmodule AshEdgeDB.Test.Profile do
  @moduledoc false
  use Ash.Resource,
    data_layer: AshEdgeDB.DataLayer

  edgedb do
    table("profile")
    schema("profiles")
    repo(AshEdgeDB.TestRepo)
  end

  attributes do
    uuid_primary_key(:id, writable?: true)
    attribute(:description, :string)
  end

  actions do
    defaults([:create, :read, :update, :destroy])
  end

  relationships do
    belongs_to(:author, AshEdgeDB.Test.Author)
  end
end
