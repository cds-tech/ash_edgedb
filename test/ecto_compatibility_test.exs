defmodule AshEdgeDB.EctoCompatibilityTest do
  use AshEdgeDB.RepoCase, async: false
  require Ash.Query

  test "call Ecto.Repo.insert! via Ash Repo" do
    org =
      %AshEdgeDB.Test.Organization{name: "The Org"}
      |> AshEdgeDB.TestRepo.insert!()

    assert org.name == "The Org"
  end
end
