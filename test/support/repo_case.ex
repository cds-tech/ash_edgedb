defmodule AshEdgeDB.RepoCase do
  @moduledoc false
  use ExUnit.CaseTemplate

  alias Ecto.Adapters.SQL.Sandbox

  using do
    quote do
      alias AshEdgeDB.TestRepo

      import Ecto
      import Ecto.Query
      import AshEdgeDB.RepoCase

      # and any other stuff
    end
  end

  setup tags do
    :ok = Sandbox.checkout(AshEdgeDB.TestRepo)

    unless tags[:async] do
      Sandbox.mode(AshEdgeDB.TestRepo, {:shared, self()})
    end

    :ok
  end
end
