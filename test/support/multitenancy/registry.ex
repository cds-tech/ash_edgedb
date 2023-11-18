defmodule AshEdgeDB.MultitenancyTest.Registry do
  @moduledoc false
  use Ash.Registry

  entries do
    entry(AshEdgeDB.MultitenancyTest.Org)
    entry(AshEdgeDB.MultitenancyTest.User)
    entry(AshEdgeDB.MultitenancyTest.Post)
  end
end
