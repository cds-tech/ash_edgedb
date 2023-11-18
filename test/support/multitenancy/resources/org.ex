defmodule AshEdgeDB.MultitenancyTest.Org do
  @moduledoc false
  use Ash.Resource,
    data_layer: AshEdgeDB.DataLayer

  identities do
    identity(:unique_by_name, [:name])
  end

  attributes do
    uuid_primary_key(:id, writable?: true)
    attribute(:name, :string)
  end

  actions do
    defaults([:create, :read, :update, :destroy])
  end

  postgres do
    table "multitenant_orgs"
    repo(AshEdgeDB.TestRepo)

    manage_tenant do
      template(["org_", :id])
    end
  end

  multitenancy do
    strategy(:attribute)
    attribute(:id)
    global?(true)
    parse_attribute({__MODULE__, :tenant, []})
  end

  relationships do
    has_many(:posts, AshEdgeDB.MultitenancyTest.Post, destination_attribute: :org_id)
    has_many(:users, AshEdgeDB.MultitenancyTest.User, destination_attribute: :org_id)
  end

  def tenant("org_" <> tenant) do
    tenant
  end
end
