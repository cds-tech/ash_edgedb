defmodule AshEdgeDB.MultitenancyTest.User do
  @moduledoc false
  use Ash.Resource,
    data_layer: AshEdgeDB.DataLayer

  attributes do
    uuid_primary_key(:id, writable?: true)
    attribute(:name, :string)
    attribute(:org_id, :uuid)
  end

  edgedb do
    table "users"
    repo AshEdgeDB.TestRepo
  end

  actions do
    defaults([:create, :read, :update, :destroy])
  end

  multitenancy do
    # Tells the resource to use the data layer
    # multitenancy, in this case separate edgedb schemas
    strategy(:attribute)
    attribute(:org_id)
    parse_attribute({__MODULE__, :parse_tenant, []})
    global?(true)
  end

  relationships do
    belongs_to(:org, AshEdgeDB.MultitenancyTest.Org)
  end

  def parse_tenant("org_" <> id), do: id
end
