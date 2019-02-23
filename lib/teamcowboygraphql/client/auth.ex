defmodule TeamCowboyGraphQL.Client.Auth do
  import TeamCowboyGraphQL
  alias TeamCowboyGraphQL.Client
  alias TeamCowboyGraphQL.Data.Api.RequestSignature

  @type auth :: %{username: binary, password: binary}

  @spec get_user_token(Client.t(), auth) :: map()
  def get_user_token(client \\ %Client{}, %{username: username, password: password}) do
    timestamp = :os.system_time(:second) |> Integer.to_string()
    nonce = :os.system_time(:nanosecond) |> Integer.to_string()

    params = %{
      method: "Auth_GetUserToken",
      api_key: client.api_key,
      username: username,
      password: password,
      timestamp: timestamp,
      nonce: nonce
    }

    sig = RequestSignature.create("POST", "Auth_GetUserToken", params)
    body = params |> Map.merge(%{sig: sig}) |> URI.encode_query()

    {200, data, _response} =
      post(client, body, [{"Content-Type", "application/x-www-form-urlencoded"}])

    data |> Map.get("body")
  end
end
