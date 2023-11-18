defmodule AshEdgeDB.Test.Money do
  @moduledoc false
  use Ash.Resource,
    data_layer: :embedded

  attributes do
    attribute :amount, :integer do
      allow_nil?(false)
      constraints(min: 0)
    end

    attribute :currency, :atom do
      constraints(one_of: [:eur, :usd])
    end
  end
end
