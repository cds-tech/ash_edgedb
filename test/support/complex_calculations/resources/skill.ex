defmodule AshEdgeDB.Test.ComplexCalculations.Skill do
  @moduledoc false
  use Ash.Resource, data_layer: AshEdgeDB.DataLayer

  actions do
    defaults([:create, :read, :update, :destroy])
  end

  aggregates do
    first :latest_documentation_status, [:documentations], :status do
      sort(timestamp: :desc)
    end
  end

  attributes do
    uuid_primary_key(:id)
    attribute(:removed, :boolean, default: false, allow_nil?: false)
  end

  calculations do
    calculate :status, :atom do
      calculation(
        expr(
          if is_nil(latest_documentation_status) do
            :pending
          else
            latest_documentation_status
          end
        )
      )
    end
  end

  edgedb do
    table "complex_calculations_skills"
    repo(AshEdgeDB.TestRepo)
  end

  relationships do
    belongs_to(:certification, AshEdgeDB.Test.ComplexCalculations.Certification)

    has_many :documentations, AshEdgeDB.Test.ComplexCalculations.Documentation do
      sort(timestamp: :desc, inserted_at: :desc)
    end

    has_one :latest_documentation, AshEdgeDB.Test.ComplexCalculations.Documentation do
      sort(timestamp: :desc, inserted_at: :desc)
    end
  end
end
