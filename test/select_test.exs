defmodule AshEdgeDB.SelectTest do
  @moduledoc false
  use AshEdgeDB.RepoCase, async: false
  alias AshEdgeDB.Test.{Api, Post}

  require Ash.Query

  test "values not selected in the query are not present in the response" do
    Post
    |> Ash.Changeset.new(%{title: "title"})
    |> Api.create!()

    assert [%{title: nil}] = Api.read!(Ash.Query.select(Post, :id))
  end
end
