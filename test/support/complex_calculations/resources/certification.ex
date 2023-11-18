defmodule AshEdgeDB.Test.ComplexCalculations.Certification do
  @moduledoc false
  use Ash.Resource, data_layer: AshEdgeDB.DataLayer

  actions do
    defaults([:create, :read, :update, :destroy])
  end

  aggregates do
    count :count_of_documented_skills, :skills do
      filter(expr(removed == false and status != :pending))
    end

    count :count_of_approved_skills, :skills do
      filter(expr(removed == false and status == :approved))
    end

    count :count_of_skills, :skills do
      filter(expr(removed == false))
    end
  end

  attributes do
    uuid_primary_key(:id)
  end

  calculations do
    calculate :all_documentation_approved, :boolean do
      calculation(expr(count_of_skills == count_of_approved_skills))
      load([:count_of_skills, :count_of_approved_skills])
    end

    calculate :some_documentation_created, :boolean do
      calculation(expr(count_of_documented_skills > 0 && all_documentation_approved == false))

      load([:count_of_documented_skills, :all_documentation_approved])
    end
  end

  postgres do
    table "complex_calculations_certifications"
    repo(AshEdgeDB.TestRepo)
  end

  relationships do
    has_many(:skills, AshEdgeDB.Test.ComplexCalculations.Skill)
  end
end
