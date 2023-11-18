defmodule AshEdgeDB.Test.ComplexCalculations.Api do
  @moduledoc false
  use Ash.Api

  resources do
    registry(AshEdgeDB.Test.ComplexCalculations.Registry)
  end
end
