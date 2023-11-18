import Config

if Mix.env() == :dev do
  config :git_ops,
    mix_project: AshEdgeDB.MixProject,
    changelog_file: "CHANGELOG.md",
    repository_url: "https://github.com/ash-project/ash_edgedb",
    # Instructs the tool to manage your mix version in your `mix.exs` file
    # See below for more information
    manage_mix_version?: true,
    # Instructs the tool to manage the version in your README.md
    # Pass in `true` to use `"README.md"` or a string to customize
    manage_readme_version: ["README.md", "documentation/tutorials/get-started-with-edgedb.md"],
    version_tag_prefix: "v"
end

if Mix.env() == :test do
  config :ash, :validate_api_resource_inclusion?, false
  config :ash, :validate_api_config_inclusion?, false

  config :ash_edgedb, AshEdgeDB.TestRepo,
    username: "edgedb",
    database: "ash_edgedb_test",
    hostname: "localhost",
    pool: Ecto.Adapters.SQL.Sandbox

  # sobelow_skip ["Config.Secrets"]
  config :ash_edgedb, AshEdgeDB.TestRepo, password: "edgedb"

  config :ash_edgedb, AshEdgeDB.TestRepo, migration_primary_key: [name: :id, type: :binary_id]

  config :ash_edgedb, AshEdgeDB.TestNoSandboxRepo,
    username: "edgedb",
    database: "ash_edgedb_test",
    hostname: "localhost"

  # sobelow_skip ["Config.Secrets"]
  config :ash_edgedb, AshEdgeDB.TestNoSandboxRepo, password: "edgedb"

  config :ash_edgedb, AshEdgeDB.TestNoSandboxRepo,
    migration_primary_key: [name: :id, type: :binary_id]

  config :ash_edgedb,
    ecto_repos: [AshEdgeDB.TestRepo, AshEdgeDB.TestNoSandboxRepo],
    ash_apis: [
      AshEdgeDB.Test.Api,
      AshEdgeDB.MultitenancyTest.Api,
      AshEdgeDB.Test.ComplexCalculations.Api
    ]

  config :logger, level: :warning
end
