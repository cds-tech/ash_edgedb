defmodule AshEdgeDB.TestNoSandboxRepo do
  @moduledoc false
  use AshEdgeDB.Repo,
    otp_app: :ash_edgedb

  def on_transaction_begin(data) do
    send(self(), data)
  end

  def installed_extensions do
    ["ash-functions", "uuid-ossp", "pg_trgm", "citext", AshEdgeDB.TestCustomExtension] --
      Application.get_env(:ash_edgedb, :no_extensions, [])
  end

  def all_tenants do
    Code.ensure_compiled(AshEdgeDB.MultitenancyTest.Org)

    AshEdgeDB.MultitenancyTest.Org
    |> AshEdgeDB.MultitenancyTest.Api.read!()
    |> Enum.map(&"org_#{&1.id}")
  end
end
