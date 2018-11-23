defmodule TeamCowboyGraphQLWeb.Router do
  use TeamCowboyGraphQLWeb, :router

  pipeline :graphql do
    plug :accepts, ["json"]
    plug TeamCowboyGraphQLWeb.Context
  end

  scope "/" do
    pipe_through :graphql

    forward "/graphiql",
            Absinthe.Plug.GraphiQL,
            schema: TeamCowboyGraphQLWeb.Schema,
            default_url: "/graphql"

    forward "/graphql", Absinthe.Plug, schema: TeamCowboyGraphQLWeb.Schema
  end
end
