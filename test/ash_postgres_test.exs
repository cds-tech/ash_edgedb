defmodule AshEdgeDBTest do
  use AshEdgeDB.RepoCase, async: false

  test "transaction metadata is given to on_transaction_begin" do
    AshEdgeDB.Test.Post
    |> Ash.Changeset.new(%{title: "title"})
    |> AshEdgeDB.Test.Api.create!()

    assert_receive %{
      type: :create,
      metadata: %{action: :create, actor: nil, resource: AshEdgeDB.Test.Post}
    }
  end
end
