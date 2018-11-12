defmodule TeamCowboyGraphQLWeb.Router do
  use TeamCowboyGraphQLWeb, :router

  forward "/graphiql",
    Absinthe.Plug.GraphiQL,
    schema: TeamCowboyGraphQLWeb.Schema

  forward "/", Absinthe.Plug,
    schema: TeamCowboyGraphQLWeb.Schema
    
end
