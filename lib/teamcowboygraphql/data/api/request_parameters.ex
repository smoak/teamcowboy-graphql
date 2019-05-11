defmodule TeamCowboyGraphQL.Data.Api.RequestParameters do
  @moduledoc """
  This is the RequestParameters module.
  """
  alias TeamCowboyGraphQL.Data.Api.RequestSignature

  def create(
        client,
        http_method,
        params,
        generate_timestamp \\ &RequestSignature.generate_timestamp/0,
        generate_nonce \\ &RequestSignature.generate_nonce/0,
        create_signature \\ &RequestSignature.create/6
      ) do
    api_method = params |> Map.get(:method)
    timestamp = generate_timestamp.()
    nonce = generate_nonce.()

    request_params =
      params
      |> Map.merge(%{
        api_key: client.public_api_key,
        nonce: nonce,
        timestamp: timestamp
      })
      |> with_user_token(client.auth)

    request_param_body =
      request_params
      |> URI.encode_query()
      |> String.replace("+", "%20")
      |> String.downcase()

    sig =
      create_signature.(
        client.private_api_key,
        http_method,
        api_method,
        timestamp,
        nonce,
        request_param_body
      )

    request_params |> Map.merge(%{sig: sig})
  end

  defp with_user_token(m, nil), do: m
  defp with_user_token(m, user_token), do: Map.merge(m, %{userToken: user_token})
end
