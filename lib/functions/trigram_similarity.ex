defmodule AshEdgeDB.Functions.TrigramSimilarity do
  @moduledoc """
  Maps to the builtin edgedb trigram similarity function. Requires `pgtrgm` extension to be installed.

  See the edgedb docs on [trigram](https://www.edgedbql.org/docs/9.6/pgtrgm.html]) for more information.

  Requires the pg_trgm extension. Configure which extensions you have installed in your `AshEdgeDB.Repo`

      # Example

      filter(query, trigram_similarity(name, "geoff") > 0.4)
  """

  use Ash.Query.Function, name: :trigram_similarity

  def args, do: [[:string, :string]]
end
