defmodule AshEdgeDB.Test.ComplexCalculations.Registry do
  @moduledoc false
  use Ash.Registry

  entries do
    entry(AshEdgeDB.Test.ComplexCalculations.Certification)
    entry(AshEdgeDB.Test.ComplexCalculations.Skill)
    entry(AshEdgeDB.Test.ComplexCalculations.Documentation)
    entry(AshEdgeDB.Test.ComplexCalculations.Channel)
    entry(AshEdgeDB.Test.ComplexCalculations.ChannelMember)
  end
end
