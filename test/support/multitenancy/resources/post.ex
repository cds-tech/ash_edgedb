defmodule AshEdgeDB.MultitenancyTest.Post do
  @moduledoc false
  use Ash.Resource,
    data_layer: AshEdgeDB.DataLayer

  attributes do
    uuid_primary_key(:id, writable?: true)
    attribute(:name, :string)
  end

  actions do
    defaults([:create, :read, :update, :destroy])
  end

  postgres do
    table "multitenant_posts"
    repo AshEdgeDB.TestRepo
  end

  multitenancy do
    # Tells the resource to use the data layer
    # multitenancy, in this case separate postgres schemas
    strategy(:context)
  end

  relationships do
    belongs_to(:org, AshEdgeDB.MultitenancyTest.Org)
    belongs_to(:user, AshEdgeDB.MultitenancyTest.User)
  end
end
