defmodule AshEdgeDB.Test.ComplexCalculations.ChannelMember do
  @moduledoc false
  use Ash.Resource,
    data_layer: AshEdgeDB.DataLayer,
    authorizers: [Ash.Policy.Authorizer]

  actions do
    defaults([:create, :read, :update, :destroy])
  end

  attributes do
    uuid_primary_key(:id)

    create_timestamp(:created_at, private?: false)
    update_timestamp(:updated_at, private?: false)
  end

  edgedb do
    table "complex_calculations_certifications_channel_members"
    repo(AshEdgeDB.TestRepo)
  end

  relationships do
    belongs_to(:user, AshEdgeDB.Test.User, api: AshEdgeDB.Test.Api)
    belongs_to(:channel, AshEdgeDB.Test.ComplexCalculations.Channel)
  end
end
