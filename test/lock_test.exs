defmodule AshEdgeDB.Test.LockTest do
  use AshEdgeDB.RepoCase, async: false
  alias AshEdgeDB.Test.{Api, Post}
  require Ash.Query

  setup do
    Application.put_env(:ash, :disable_async?, true)

    on_exit(fn ->
      Application.put_env(:ash, :disable_async?, false)
      AshEdgeDB.TestNoSandboxRepo.delete_all(Post)
    end)
  end

  test "lock conflicts raise appropriate errors" do
    post =
      Post
      |> Ash.Changeset.for_create(:create, %{title: "locked"})
      |> Ash.Changeset.set_context(%{data_layer: %{repo: AshEdgeDB.TestNoSandboxRepo}})
      |> Api.create!()

    task1 =
      Task.async(fn ->
        AshEdgeDB.TestNoSandboxRepo.transaction(fn ->
          Post
          |> Ash.Query.lock("FOR UPDATE NOWAIT")
          |> Ash.Query.set_context(%{data_layer: %{repo: AshEdgeDB.TestNoSandboxRepo}})
          |> Ash.Query.filter(id == ^post.id)
          |> Api.read!()

          :timer.sleep(1000)
          :ok
        end)
      end)

    task2 =
      Task.async(fn ->
        try do
          AshEdgeDB.TestNoSandboxRepo.transaction(fn ->
            :timer.sleep(100)

            Post
            |> Ash.Query.lock("FOR UPDATE NOWAIT")
            |> Ash.Query.set_context(%{data_layer: %{repo: AshEdgeDB.TestNoSandboxRepo}})
            |> Ash.Query.filter(id == ^post.id)
            |> Api.read!()
          end)
        rescue
          e ->
            {:error, e}
        end
      end)

    assert [{:ok, :ok}, {:error, %Ash.Error.Invalid{errors: [%Ash.Error.Invalid.Unavailable{}]}}] =
             Task.await_many([task1, task2], :infinity)
  end
end
