defmodule TeamCowboyGraphQL.Data.Api.RequestSignature do
  @moduledoc """
  This is the RequestSignature module. It provides a
  way to create the "sig" parameter required for all
  TeamCowboy requests.
  See: http://api.teamcowboy.com/v1/docs/#_Toc372547906
  """

  @spec create(String.t(), String.t(), String.t(), String.t(), String.t(), String.t()) ::
          String.t()
  def create(private_api_key, http_method, api_method, timestamp, nonce, request_param_body) do
    [
      private_api_key,
      http_method |> String.upcase(),
      api_method,
      timestamp,
      nonce,
      request_param_body
    ]
    |> Enum.join("|")
    |> sha1hash()
  end

  def generate_nonce, do: :os.system_time(:nanosecond) |> Integer.to_string()
  def generate_timestamp, do: :os.system_time(:second) |> Integer.to_string()

  @spec sha1hash(String.t()) :: String.t()
  defp sha1hash(str) do
    :crypto.hash(:sha, str) |> Base.encode16() |> String.downcase()
  end
end
