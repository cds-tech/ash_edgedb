defmodule AshEdgeDB.DataLayer.Info do
  @moduledoc "Introspection functions for "

  alias Spark.Dsl.Extension

  @doc "The configured repo for a resource"
  def repo(resource, type \\ :mutate) do
    case Extension.get_opt(resource, [:edgedb], :repo, nil, true) do
      fun when is_function(fun, 2) ->
        fun.(resource, type)

      repo ->
        repo
    end
  end

  @doc "The configured table for a resource"
  def table(resource) do
    Extension.get_opt(resource, [:edgedb], :table, nil, true)
  end

  def simple_join_first_aggregates(resource) do
    Extension.get_opt(resource, [:edgedb], :simple_join_first_aggregates, [])
  end

  @doc "The configured schema for a resource"
  def schema(resource) do
    Extension.get_opt(resource, [:edgedb], :schema, nil, true)
  end

  @doc "The configured references for a resource"
  def references(resource) do
    Extension.get_entities(resource, [:edgedb, :references])
  end

  @doc "The configured reference for a given relationship of a  resource"
  def reference(resource, relationship) do
    resource
    |> Extension.get_entities([:edgedb, :references])
    |> Enum.find(&(&1.relationship == relationship))
  end

  @doc "A keyword list of customized migration types"
  def migration_types(resource) do
    Extension.get_opt(resource, [:edgedb], :migration_types, [])
  end

  @doc "A keyword list of customized migration defaults"
  def migration_defaults(resource) do
    Extension.get_opt(resource, [:edgedb], :migration_defaults, [])
  end

  @doc "A list of attributes to be ignored when generating migrations"
  def migration_ignore_attributes(resource) do
    Extension.get_opt(resource, [:edgedb], :migration_ignore_attributes, [])
  end

  @doc "The configured check_constraints for a resource"
  def check_constraints(resource) do
    Extension.get_entities(resource, [:edgedb, :check_constraints])
  end

  @doc "The configured custom_indexes for a resource"
  def custom_indexes(resource) do
    Extension.get_entities(resource, [:edgedb, :custom_indexes])
  end

  @doc "The configured custom_statements for a resource"
  def custom_statements(resource) do
    Extension.get_entities(resource, [:edgedb, :custom_statements])
  end

  @doc "The configured polymorphic_reference_on_delete for a resource"
  def polymorphic_on_delete(resource) do
    Extension.get_opt(resource, [:edgedb, :references], :polymorphic_on_delete, nil, true)
  end

  @doc "The configured polymorphic_reference_on_update for a resource"
  def polymorphic_on_update(resource) do
    Extension.get_opt(resource, [:edgedb, :references], :polymorphic_on_update, nil, true)
  end

  @doc "The configured polymorphic_reference_name for a resource"
  def polymorphic_name(resource) do
    Extension.get_opt(resource, [:edgedb, :references], :polymorphic_on_delete, nil, true)
  end

  @doc "The configured polymorphic? for a resource"
  def polymorphic?(resource) do
    Extension.get_opt(resource, [:edgedb], :polymorphic?, nil, true)
  end

  @doc "The configured unique_index_names"
  def unique_index_names(resource) do
    Extension.get_opt(resource, [:edgedb], :unique_index_names, [], true)
  end

  @doc "The configured exclusion_constraint_names"
  def exclusion_constraint_names(resource) do
    Extension.get_opt(resource, [:edgedb], :exclusion_constraint_names, [], true)
  end

  @doc "The configured identity_index_names"
  def identity_index_names(resource) do
    Extension.get_opt(resource, [:edgedb], :identity_index_names, [], true)
  end

  @doc "Identities not to include in the migrations"
  def skip_identities(resource) do
    Extension.get_opt(resource, [:edgedb], :skip_identities, [], true)
  end

  @doc "The configured foreign_key_names"
  def foreign_key_names(resource) do
    Extension.get_opt(resource, [:edgedb], :foreign_key_names, [], true)
  end

  @doc "Whether or not the resource should be included when generating migrations"
  def migrate?(resource) do
    Extension.get_opt(resource, [:edgedb], :migrate?, nil, true)
  end

  @doc "A list of keys to always include in upserts."
  def global_upsert_keys(resource) do
    Extension.get_opt(resource, [:edgedb], :global_upsert_keys, [])
  end

  @doc "A stringified version of the base_filter, to be used in a where clause when generating unique indexes"
  def base_filter_sql(resource) do
    Extension.get_opt(resource, [:edgedb], :base_filter_sql, nil)
  end

  @doc "Skip generating unique indexes when generating migrations"
  def skip_unique_indexes(resource) do
    Extension.get_opt(resource, [:edgedb], :skip_unique_indexes, [])
  end

  @doc "The template for a managed tenant"
  def manage_tenant_template(resource) do
    Extension.get_opt(resource, [:edgedb, :manage_tenant], :template, nil)
  end

  @doc "Whether or not to create a tenant for a given resource"
  def manage_tenant_create?(resource) do
    Extension.get_opt(resource, [:edgedb, :manage_tenant], :create?, false)
  end

  @doc "Whether or not to update a tenant for a given resource"
  def manage_tenant_update?(resource) do
    Extension.get_opt(resource, [:edgedb, :manage_tenant], :update?, false)
  end
end
