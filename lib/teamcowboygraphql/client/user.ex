defmodule TeamCowboyGraphQL.Client.User do
  import TeamCowboyGraphQL
  alias TeamCowboyGraphQL.Client
  alias TeamCowboyGraphQL.Data.Api.RequestSignature

  @spec get_teams(Client.t(), %{dashboard_only: boolean}) :: list(map())
  def get_teams(client \\ %Client{}, %{dashboard_only: dashboard_only}) do
    timestamp = :os.system_time(:second) |> Integer.to_string()
    nonce = :os.system_time(:nanosecond) |> Integer.to_string()

    params = %{
      method: "User_GetTeams",
      api_key: client.api_key,
      dashboardTeamsOnly: dashboard_only,
      userToken: client.auth,
      timestamp: timestamp,
      nonce: nonce
    }

    sig = RequestSignature.create("GET", "User_GetTeams", params)
    request_params = params |> Map.merge(%{sig: sig})

    {200, data, _} = get(client, [], request_params)

    data |> Map.get("body")
  end

  @spec get(Client.t()) :: map()
  def get(client \\ %Client{}) do
    timestamp = :os.system_time(:second) |> Integer.to_string()
    nonce = :os.system_time(:nanosecond) |> Integer.to_string()

    params = %{
      method: "User_Get",
      api_key: client.api_key,
      userToken: client.auth,
      timestamp: timestamp,
      nonce: nonce
    }

    sig = RequestSignature.create("GET", "User_Get", params)
    request_params = params |> Map.merge(%{sig: sig})

    {200, data, _} = get(client, [], request_params)

    data |> Map.get("body")
  end
end
