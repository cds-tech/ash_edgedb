defmodule AshEdgeDB.Test.PostView do
  @moduledoc false
  use Ash.Resource, data_layer: AshEdgeDB.DataLayer

  actions do
    defaults([:create, :read])
  end

  attributes do
    create_timestamp(:time)
    attribute(:browser, :atom, constraints: [one_of: [:firefox, :chrome, :edge]])
  end

  relationships do
    belongs_to :post, AshEdgeDB.Test.Post do
      allow_nil?(false)
      attribute_writable?(true)
    end
  end

  resource do
    require_primary_key?(false)
  end

  postgres do
    table "post_views"
    repo AshEdgeDB.TestRepo

    references do
      reference :post, ignore?: true
    end
  end
end
