defmodule AshEdgeDB.Functions.Like do
  @moduledoc """
  Maps to the builtin edgedb function `like`.
  """

  use Ash.Query.Function, name: :like

  def args, do: [[:string, :string]]
end
