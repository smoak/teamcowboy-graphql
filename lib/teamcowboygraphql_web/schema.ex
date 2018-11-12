defmodule TeamCowboyGraphQLWeb.Schema do
  use Absinthe.Schema

  alias TeamCowboyGraphQLWeb.Resolvers

  @desc "A team"
  object :team do
    field :team_id, non_null(:integer)
  end

  query([name: "Query"]) do
    @desc "Get teams for a user"
    field :teams, non_null(list_of(:team)) do
      @desc "Whether or not to restrict the teams retrieved only to those on the user’s Dashboard."
      arg :dashboard_only, :boolean, default_value: false

      resolve &Resolvers.Teams.list/3
    end
  end
end