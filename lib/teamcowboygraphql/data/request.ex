defmodule TeamCowboyGraphQL.Data.Request do
  def create_signature(http_method, api_method, request_params),
    do:
      create_signature(
        http_method,
        api_method,
        request_params,
        fn ->
          :os.system_time(:millisecond)
        end,
        fn -> :os.system_time(:nanosecond) end
      )

  def create_signature(http_method, api_method, request_params, current_timestamp, generate_nonce) do
    [{:private_api_key, private_api_key}, _] =
      Application.fetch_env!(:teamcowboygraphql, :teamcowboy_config)

    timestamp = current_timestamp.() |> Integer.to_string()
    nonce = generate_nonce.() |> Integer.to_string()

    request_string = generate_request_string(nonce, timestamp, request_params)

    :crypto.hash(
      :sha,
      [
        private_api_key,
        http_method |> String.upcase(),
        api_method,
        timestamp,
        nonce,
        request_string
      ]
      |> Enum.join("|")
    )
    |> Base.encode16()
    |> String.downcase()
  end

  def generate_request_string(nonce, timestamp, request_params) do
    request_map = %{nonce: nonce, timestamp: timestamp} |> Map.merge(request_params)

    request_map
    |> Map.keys()
    |> Enum.sort()
    |> Enum.reduce(
      [],
      fn key, acc ->
        acc
        |> Enum.concat([
          "#{key}=#{request_map |> Map.get(key) |> URI.encode() |> String.downcase()}"
        ])
      end
    )
    |> Enum.join("&")
  end
end
