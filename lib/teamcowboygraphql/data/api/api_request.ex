defmodule TeamCowboyGraphQL.Data.Api.ApiRequest do
  alias TeamCowboyGraphQL.Data.Api.RequestSignature

  defmodule TeamCowboyResponse do
    @derive [Poison.Encoder]
    defstruct [:success, :body]
  end

  def execute(user_token, api_method, api_params) do
    teamcowboy_host =
      Application.fetch_env!(:teamcowboygraphql, :teamcowboy_config) |> Keyword.fetch!(:host)

    request_params = create_request_params(user_token, api_method, api_params)

    {:ok, %HTTPoison.Response{status_code: 200, body: body}} =
      HTTPoison.get(teamcowboy_host, [], params: request_params)

    case body |> Poison.decode!(as: %TeamCowboyResponse{}) do
      %{success: true, body: resp} -> {:ok, resp}
      %{success: false, body: %{error: %{message: error}}} -> {:error, error}
    end
  end

  defp create_request_params(user_token, api_method, api_params) do
    public_api_key =
      Application.fetch_env!(:teamcowboygraphql, :teamcowboy_config)
      |> Keyword.fetch!(:public_api_key)

    timestamp = :os.system_time(:second) |> Integer.to_string()
    nonce = :os.system_time(:nanosecond) |> Integer.to_string()

    request_params =
      %{
        method: api_method,
        api_key: public_api_key,
        userToken: user_token,
        timestamp: timestamp,
        nonce: nonce
      }
      |> Map.merge(api_params)

    sig =
      RequestSignature.create(
        "GET",
        api_method,
        request_params
      )

    request_params |> Map.merge(%{sig: sig})
  end
end
