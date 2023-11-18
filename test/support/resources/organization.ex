defmodule AshEdgeDB.Test.Organization do
  @moduledoc false
  use Ash.Resource,
    data_layer: AshEdgeDB.DataLayer

  postgres do
    table("orgs")
    repo(AshEdgeDB.TestRepo)
  end

  actions do
    defaults([:create, :read, :update, :destroy])
  end

  attributes do
    uuid_primary_key(:id, writable?: true)
    attribute(:name, :string)
  end

  relationships do
    has_many(:users, AshEdgeDB.Test.User)
    has_many(:posts, AshEdgeDB.Test.Post)
    has_many(:managers, AshEdgeDB.Test.Manager)
  end
end
