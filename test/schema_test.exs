defmodule AshEdgeDB.SchemaTest do
  @moduledoc false
  use AshEdgeDB.RepoCase, async: false
  alias AshEdgeDB.Test.{Api, Author, Profile}

  require Ash.Query

  setup do
    [author: Api.create!(Ash.Changeset.for_create(Author, :create, %{}))]
  end

  test "data can be created", %{author: author} do
    assert %{description: "foo"} =
             Profile
             |> Ash.Changeset.for_create(:create, %{description: "foo"})
             |> Ash.Changeset.manage_relationship(:author, author, type: :append_and_remove)
             |> Api.create!()
  end

  test "data can be read", %{author: author} do
    Profile
    |> Ash.Changeset.for_create(:create, %{description: "foo"})
    |> Ash.Changeset.manage_relationship(:author, author, type: :append_and_remove)
    |> Api.create!()

    assert [%{description: "foo"}] = Profile |> Api.read!()
  end

  test "they can be filtered across", %{author: author} do
    profile =
      Profile
      |> Ash.Changeset.for_create(:create, %{description: "foo"})
      |> Ash.Changeset.manage_relationship(:author, author, type: :append_and_remove)
      |> Api.create!()

    Api.create!(Ash.Changeset.for_create(Author, :create, %{}))

    assert [_] =
             Author
             |> Ash.Query.filter(profile.id == ^profile.id)
             |> Api.read!()

    assert [_] =
             Profile
             |> Ash.Query.filter(author.id == ^author.id)
             |> Api.read!()
  end

  test "aggregates work across schemas", %{author: author} do
    Profile
    |> Ash.Changeset.for_create(:create, %{description: "foo"})
    |> Ash.Changeset.manage_relationship(:author, author, type: :append_and_remove)
    |> Api.create!()

    assert [%{profile_description: "foo"}] =
             Author
             |> Ash.Query.filter(profile_description == "foo")
             |> Ash.Query.load(:profile_description)
             |> Api.read!()

    assert %{profile_description: "foo"} = Api.load!(author, :profile_description)
  end
end
