# AshEdgeDB

![Elixir CI](https://github.com/ash-project/ash_edgedb/workflows/Elixir%20CI/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Coverage Status](https://coveralls.io/repos/github/ash-project/ash_edgedb/badge.svg?branch=main)](https://coveralls.io/github/ash-project/ash_edgedb?branch=main)
[![Hex version badge](https://img.shields.io/hexpm/v/ash_edgedb.svg)](https://hex.pm/packages/ash_edgedb)

AshEdgeDB supports all the capabilities of an Ash data layer. AshEdgeDB is the primary Ash data layer.

Custom Predicates:

- `AshEdgeDB.Predicates.Trigram`

## DSL

See the DSL documentation in `AshEdgeDB.DataLayer` for DSL documentation

## Usage

Add `ash_edgedb` to your `mix.exs` file.

```elixir
{:ash_edgedb, "~> 1.3.6"}
```

To use this data layer, you need to chage your Ecto Repo's from `use Ecto.Repo`,
to `use AshEdgeDB.Repo`. because AshEdgeDB adds functionality to Ecto Repos.

Then, configure each of your `Ash.Resource` resources by adding `use Ash.Resource, data_layer: AshEdgeDB.DataLayer` like so:

```elixir
defmodule MyApp.SomeResource do
  use Ash.Resource, data_layer: AshEdgeDB.DataLayer

  edgedb do
    repo MyApp.Repo
    table "table_name"
  end

  attributes do
    # ... Attribute definitions
  end
end
```

## Generating Migrations

See the documentation for `Mix.Tasks.AshEdgeDB.GenerateMigrations` for how to generate
migrations from your resources

# Contributors

Ash is made possible by its excellent community!

<a href="https://github.com/ash-project/ash_edgedb/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=ash-project/ash_edgedb" />
</a>

[Become a contributor](https://ash-hq.org/docs/guides/ash/latest/how_to/contribute.md)
