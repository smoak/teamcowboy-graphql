defmodule TeamCowboyGraphQL.Data.Api.RequestBody do
  @moduledoc """
  This is the RequestBody module.
  """
  alias TeamCowboyGraphQL.Data.Api.RequestSignature

  @doc """
  Creates a uri encoded request body
  """
  @spec create(String.t(), String.t(), String.t(), map()) :: binary()
  def create(api_key, http_method, api_method, request_params) do
    timestamp = :os.system_time(:second) |> Integer.to_string()
    nonce = :os.system_time(:nanosecond) |> Integer.to_string()

    params =
      %{
        method: api_method,
        api_key: api_key,
        timestamp: timestamp,
        nonce: nonce
      }
      |> Map.merge(request_params)

    sig = RequestSignature.create(http_method, api_method, params)
    params |> Map.merge(%{sig: sig}) |> URI.encode_query()
  end
end
