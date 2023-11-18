defmodule AshEdgeDB.Test.Registry do
  @moduledoc false
  use Ash.Registry

  entries do
    entry(AshEdgeDB.Test.Post)
    entry(AshEdgeDB.Test.Comment)
    entry(AshEdgeDB.Test.IntegerPost)
    entry(AshEdgeDB.Test.Rating)
    entry(AshEdgeDB.Test.PostLink)
    entry(AshEdgeDB.Test.PostView)
    entry(AshEdgeDB.Test.Author)
    entry(AshEdgeDB.Test.Profile)
    entry(AshEdgeDB.Test.User)
    entry(AshEdgeDB.Test.Account)
    entry(AshEdgeDB.Test.Organization)
    entry(AshEdgeDB.Test.Manager)
  end
end
