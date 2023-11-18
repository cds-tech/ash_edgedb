defmodule AshEdgeDB.EnumTest do
  @moduledoc false
  use AshEdgeDB.RepoCase, async: false
  alias AshEdgeDB.Test.{Api, Post}

  require Ash.Query

  test "valid values are properly inserted" do
    Post
    |> Ash.Changeset.new(%{title: "title", status: :open})
    |> Api.create!()
  end
end
