defmodule Mix.Tasks.AshEdgeDB.Drop do
  use Mix.Task

  @shortdoc "Drops the repository storage for the repos in the specified (or configured) apis"
  @default_opts [force: false, force_drop: false]

  @aliases [
    f: :force,
    q: :quiet
  ]

  @switches [
    force: :boolean,
    force_drop: :boolean,
    quiet: :boolean,
    apis: :string,
    no_compile: :boolean,
    no_deps_check: :boolean
  ]

  @moduledoc """
  Drop the storage for the given repository.

  ## Examples

      mix ash_edgedb.drop
      mix ash_edgedb.drop -r MyApp.Api1,MyApp.Api2

  ## Command line options

    * `--apis` - the apis who's repos should be dropped
    * `-q`, `--quiet` - run the command quietly
    * `-f`, `--force` - do not ask for confirmation when dropping the database.
      Configuration is asked only when `:start_permanent` is set to true
      (typically in production)
    * `--force-drop` - force the database to be dropped even
      if it has connections to it (requires PostgreSQL 13+)
    * `--no-compile` - do not compile before dropping
    * `--no-deps-check` - do not compile before dropping
  """

  @doc false
  def run(args) do
    {opts, _} = OptionParser.parse!(args, strict: @switches, aliases: @aliases)
    opts = Keyword.merge(@default_opts, opts)

    repos = AshEdgeDB.MixHelpers.repos!(opts, args)

    repo_args =
      Enum.flat_map(repos, fn repo ->
        ["-r", to_string(repo)]
      end)

    rest_opts = AshEdgeDB.MixHelpers.delete_arg(args, "--apis")

    Mix.Task.run("ecto.drop", repo_args ++ rest_opts)
  end
end
