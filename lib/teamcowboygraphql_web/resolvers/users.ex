defmodule TeamCowboyGraphQLWeb.Resolvers.Users do
  alias TeamCowboyGraphQL.Data.TeamCowboy.UserToken
  alias TeamCowboyGraphQL.Client.Users

  @spec create_token(map(), %{username: String.t(), password: String.t()}, map()) ::
          {:ok, UserToken.t()}
  def create_token(_parent, %{username: username, password: password}, _context) do
    {:ok, Users.authenticate(username, password)}
  end
end
