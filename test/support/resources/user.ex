defmodule AshEdgeDB.Test.User do
  @moduledoc false
  use Ash.Resource, data_layer: AshEdgeDB.DataLayer

  actions do
    defaults([:create, :read, :update, :destroy])
  end

  attributes do
    uuid_primary_key(:id)
    attribute(:is_active, :boolean)
    attribute(:name, :string)
  end

  edgedb do
    table "users"
    repo(AshEdgeDB.TestRepo)
  end

  relationships do
    belongs_to(:organization, AshEdgeDB.Test.Organization)
    has_many(:accounts, AshEdgeDB.Test.Account)
  end
end
