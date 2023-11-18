defmodule AshEdgeDB.Test.StringAgg do
  @moduledoc false
  use Ash.Resource.Aggregate.CustomAggregate
  use AshEdgeDB.CustomAggregate

  require Ecto.Query

  def dynamic(opts, binding) do
    Ecto.Query.dynamic(
      [],
      fragment("string_agg(?, ?)", field(as(^binding), ^opts[:field]), ^opts[:delimiter])
    )
  end
end
