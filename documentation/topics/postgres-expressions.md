# Postgres Expressions

In addition to the expressions listed in the [Ash expressions guide](https://hexdocs.pm/ash/expressions.html), AshEdgeDB provides the following expressions

## Fragments

`fragment` allows you to embed raw sql into the query. Use question marks to interpolate values from the outer expression.

For example:

```elixir
Ash.Query.filter(User, fragment("? IS NOT NULL", first_name))
```

# Like and ILike

These wrap the edgedb builtin like and ilike operators.

Please be aware, these match _patterns_ not raw text. Use `contains/1` if you want to match text without supporting patterns, i.e `%` and `_` have semantic meaning!

For example:

```elixir
Ash.Query.filter(User, like(name, "%obo%")) # name contains obo anywhere in the string, case sensitively
```

```elixir
Ash.Query.filter(User, ilike(name, "%ObO%")) # name contains ObO anywhere in the string, case insensitively
```

# Trigram similarity

To use this expression, you must have the `pg_trgm` extension in your repos `installed_extensions` list.

This calls the `similarity` function from that extension. See more https://www.edgedbql.org/docs/current/pgtrgm.htmlhere: https://www.edgedbql.org/docs/current/pgtrgm.html

For example:

```elixir
Ash.Query.filter(User, trigram_similarity(first_name, "fred") > 0.8)
```
