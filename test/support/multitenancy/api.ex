defmodule AshEdgeDB.MultitenancyTest.Api do
  @moduledoc false
  use Ash.Api

  resources do
    registry(AshEdgeDB.MultitenancyTest.Registry)
  end
end
