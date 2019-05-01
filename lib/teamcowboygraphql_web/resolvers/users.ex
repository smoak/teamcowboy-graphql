defmodule TeamCowboyGraphQLWeb.Resolvers.Users do
  alias TeamCowboyGraphQL.Data.TeamCowboy.UserToken
  alias TeamCowboyGraphQL.Data.TeamCowboy.User
  alias TeamCowboyGraphQL.Client.Auth
  alias TeamCowboyGraphQL.Client.User, as: UserClient
  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Users

  @spec create_token(map(), %{username: String.t(), password: String.t()}, map()) ::
          {:ok, UserToken.t()}
  def create_token(_parent, %{username: _, password: _} = params, %{context: %{client: client}}) do
    case Auth.get_user_token(client, params) do
      {:ok, %{"token" => token, "userId" => _}} -> {:ok, %UserToken{token: token}}
      {:error, msg} -> {:error, msg}
      _ -> {:error, "Unknown error"}
    end
  end

  @spec get(map(), map(), map()) :: {:ok, User.t()}
  def get(_parent, _params, %{context: %{client: client}}) do
    user = client |> UserClient.get() |> Users.normalize_user()

    {:ok, user}
  end
end
