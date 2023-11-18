defmodule AshEdgeDB.TestApp do
  @moduledoc false
  def start(_type, _args) do
    children = [
      AshEdgeDB.TestRepo
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AshEdgeDB.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
