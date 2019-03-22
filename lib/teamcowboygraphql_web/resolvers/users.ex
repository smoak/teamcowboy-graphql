defmodule TeamCowboyGraphQLWeb.Resolvers.Users do
  alias TeamCowboyGraphQL.Data.TeamCowboy.UserToken
  alias TeamCowboyGraphQL.Data.TeamCowboy.User
  alias TeamCowboyGraphQL.Client.Auth
  alias TeamCowboyGraphQL.Client.User, as: UserClient
  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Users

  @spec create_token(map(), %{username: String.t(), password: String.t()}, map()) ::
          {:ok, UserToken.t()}
  def create_token(_parent, %{username: _, password: _} = params, %{context: %{client: client}}) do
    %{"token" => token, "userId" => _} = Auth.get_user_token(client, params)

    {:ok, %UserToken{token: token}}
  end

  @spec get(map(), map(), map()) :: {:ok, User.t()}
  def get(_parent, _params, %{context: %{client: client}}) do
    user = client |> UserClient.get() |> Users.normalize_user()

    {:ok, user}
  end
end
