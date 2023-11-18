defmodule AshEdgeDB.Test.Account do
  @moduledoc false
  use Ash.Resource, data_layer: AshEdgeDB.DataLayer

  actions do
    defaults([:create, :read, :update, :destroy])
  end

  aggregates do
    first(:user_is_active, :user, :is_active)
  end

  attributes do
    uuid_primary_key(:id)
    attribute(:is_active, :boolean)
  end

  calculations do
    calculate(
      :active,
      :boolean,
      expr(is_active && user_is_active),
      load: [:user_is_active]
    )
  end

  edgedb do
    table "accounts"
    repo(AshEdgeDB.TestRepo)
  end

  relationships do
    belongs_to(:user, AshEdgeDB.Test.User)
  end
end
