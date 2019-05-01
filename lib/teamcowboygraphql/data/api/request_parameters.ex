defmodule TeamCowboyGraphQL.Data.Api.RequestParameters do
  @moduledoc """
  This is the RequestParameters module.
  """
  alias TeamCowboyGraphQL.Data.Api.RequestSignature

  @doc """
  Creates a map of required TeamCowboy request parameters
  """
  @spec create(String.t(), String.t(), map(), String.t() | nil) :: binary()
  def create(http_method, api_method, extra_request_params \\ %{}, user_token \\ nil) do
    api_key =
      Application.fetch_env!(:teamcowboygraphql, :teamcowboy_config)
      |> Keyword.fetch!(:public_api_key)

    timestamp = :os.system_time(:second) |> Integer.to_string()
    nonce = :os.system_time(:nanosecond) |> Integer.to_string()

    params =
      %{
        method: api_method,
        api_key: api_key,
        timestamp: timestamp,
        nonce: nonce
      }
      |> Map.merge(extra_request_params)
      |> Map.merge(with_user_token(user_token))

    sig = RequestSignature.create(http_method, api_method, params)
    params |> Map.merge(%{sig: sig})
  end

  defp with_user_token(nil), do: %{}
  defp with_user_token(user_token), do: %{userToken: user_token}
end
