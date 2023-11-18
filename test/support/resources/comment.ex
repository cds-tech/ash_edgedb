defmodule AshEdgeDB.Test.Comment do
  @moduledoc false
  use Ash.Resource,
    data_layer: AshEdgeDB.DataLayer,
    authorizers: [
      Ash.Policy.Authorizer
    ]

  policies do
    bypass action_type(:read) do
      # Check that the comment is in the same org (via post) as actor
      authorize_if(relates_to_actor_via([:post, :organization, :users]))
    end
  end

  edgedb do
    table "comments"
    repo(AshEdgeDB.TestRepo)

    references do
      reference(:post, on_delete: :delete, on_update: :update, name: "special_name_fkey")
    end
  end

  actions do
    defaults([:read, :update, :destroy])

    create :create do
      primary?(true)
      argument(:rating, :map)

      change(manage_relationship(:rating, :ratings, on_missing: :ignore, on_match: :create))
    end
  end

  attributes do
    uuid_primary_key(:id)
    attribute(:title, :string)
    attribute(:likes, :integer)
    attribute(:arbitrary_timestamp, :utc_datetime_usec)
    create_timestamp(:created_at, writable?: true)
  end

  aggregates do
    first(:post_category, :post, :category)
    count(:co_popular_comments, [:post, :popular_comments])
    count(:count_of_comments_containing_title, [:post, :comments_containing_title])
    list(:posts_for_comments_containing_title, [:post, :comments_containing_title, :post], :title)
  end

  relationships do
    belongs_to(:post, AshEdgeDB.Test.Post)
    belongs_to(:author, AshEdgeDB.Test.Author)

    has_many(:ratings, AshEdgeDB.Test.Rating,
      destination_attribute: :resource_id,
      relationship_context: %{data_layer: %{table: "comment_ratings"}}
    )

    has_many(:popular_ratings, AshEdgeDB.Test.Rating,
      destination_attribute: :resource_id,
      relationship_context: %{data_layer: %{table: "comment_ratings"}},
      filter: expr(score > 5)
    )
  end
end
