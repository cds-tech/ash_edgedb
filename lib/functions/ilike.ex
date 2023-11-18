defmodule AshEdgeDB.Functions.ILike do
  @moduledoc """
  Maps to the builtin edgedb function `ilike`.
  """

  use Ash.Query.Function, name: :ilike

  def args, do: [[:string, :string]]
end
