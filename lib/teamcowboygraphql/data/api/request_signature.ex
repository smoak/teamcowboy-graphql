defmodule TeamCowboyGraphQL.Data.Api.RequestSignature do
  def create(http_method, api_method, request_params) do
    private_api_key =
      Application.fetch_env!(:teamcowboygraphql, :teamcowboy_config)
      |> Keyword.fetch!(:private_api_key)

    request_string = generate_request_string(request_params)

    :crypto.hash(
      :sha,
      [
        private_api_key,
        http_method |> String.upcase(),
        api_method,
        request_params |> Map.get(:timestamp),
        request_params |> Map.get(:nonce),
        request_string
      ]
      |> Enum.join("|")
    )
    |> Base.encode16()
    |> String.downcase()
  end

  defp generate_request_string(request_params) do
    request_params
    |> Map.keys()
    |> Enum.sort()
    |> Enum.map(fn key ->
      {key |> Atom.to_string() |> String.downcase(),
       %{key => Map.get(request_params, key)}
       |> URI.encode_query()
       |> String.split("=")
       |> List.last()
       |> String.downcase()}
    end)
    |> URI.encode_query()
  end
end
