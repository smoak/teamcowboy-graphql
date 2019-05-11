defmodule TeamCowboyGraphQL.Client.Auth do
  import TeamCowboyGraphQL
  alias TeamCowboyGraphQL.Client
  alias TeamCowboyGraphQL.Data.Api.RequestParameters
  alias TeamCowboyGraphQL.Data.Api.TeamCowboyResponse

  @type auth :: %{username: binary, password: binary}

  @spec get_user_token(Client.t(), auth) :: map()
  def get_user_token(client \\ %Client{}, %{username: username, password: password}) do
    params = %{
      username: username,
      password: password,
      method: "Auth_GetUserToken"
    }

    body = RequestParameters.create(client, "POST", params) |> URI.encode_query()

    client |> post(body) |> TeamCowboyResponse.process()
  end
end
