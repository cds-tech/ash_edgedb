defmodule AshEdgeDB.Test.Api do
  @moduledoc false
  use Ash.Api

  resources do
    registry(AshEdgeDB.Test.Registry)
  end
end
