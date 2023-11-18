defmodule AshEdgeDB.Test.IntegerPost do
  @moduledoc false
  use Ash.Resource,
    data_layer: AshEdgeDB.DataLayer

  edgedb do
    table "integer_posts"
    repo AshEdgeDB.TestRepo
  end

  actions do
    defaults([:create, :read, :update, :destroy])
  end

  attributes do
    integer_primary_key(:id)
    attribute(:title, :string)
  end
end
