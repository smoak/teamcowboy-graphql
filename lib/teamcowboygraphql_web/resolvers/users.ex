defmodule TeamCowboyGraphQLWeb.Resolvers.Users do
  alias TeamCowboyGraphQL.Data.TeamCowboy.UserToken
  alias TeamCowboyGraphQL.Client.Auth

  @spec create_token(map(), %{username: String.t(), password: String.t()}, map()) ::
          {:ok, UserToken.t()}
  def create_token(_parent, %{username: _, password: _} = params, %{context: %{client: client}}) do
    %{"token" => token, "userId" => _} = Auth.get_user_token(client, params)

    {:ok, %UserToken{token: token}}
  end
end
