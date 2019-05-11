defmodule TeamCowboyGraphQL.Data.Api.RequestParametersTest do
  use ExUnit.Case

  alias TeamCowboyGraphQL.Data.Api.RequestParameters
  alias TeamCowboyGraphQL.Client

  def fake_create_signature(_, _, _, _, _, _), do: "signature"
  def fake_generate_nonce, do: 1
  def fake_generate_timestamp, do: 12

  describe ".create" do
    setup do
      {:ok,
       params: %{method: "SomeMethod"},
       client: %Client{private_api_key: "private", public_api_key: "public", auth: nil}}
    end

    test "it adds the public api key", state do
      client = state[:client]
      params = state[:params]

      rp =
        RequestParameters.create(
          client,
          "GET",
          params,
          &fake_generate_timestamp/0,
          &fake_generate_nonce/0,
          &fake_create_signature/6
        )

      assert rp |> Map.get(:api_key) == "public"
    end

    test "it adds the nonce", state do
      client = state[:client]
      params = state[:params]

      rp =
        RequestParameters.create(
          client,
          "GET",
          params,
          &fake_generate_timestamp/0,
          &fake_generate_nonce/0,
          &fake_create_signature/6
        )

      assert rp |> Map.get(:nonce) == 1
    end

    test "it adds the timestamp", state do
      client = state[:client]
      params = state[:params]

      rp =
        RequestParameters.create(
          client,
          "GET",
          params,
          &fake_generate_timestamp/0,
          &fake_generate_nonce/0,
          &fake_create_signature/6
        )

      assert rp |> Map.get(:timestamp) == 12
    end

    test "when the client has authed it adds the user token", state do
      client = %Client{private_api_key: "private", public_api_key: "public", auth: "foo"}
      params = state[:params]

      rp =
        RequestParameters.create(
          client,
          "GET",
          params,
          &fake_generate_timestamp/0,
          &fake_generate_nonce/0,
          &fake_create_signature/6
        )

      assert rp |> Map.get(:userToken) == "foo"
    end

    test "it adds the sig parameter", state do
      client = state[:client]
      params = state[:params]

      rp =
        RequestParameters.create(
          client,
          "GET",
          params,
          &fake_generate_timestamp/0,
          &fake_generate_nonce/0,
          &fake_create_signature/6
        )

      assert rp |> Map.get(:sig) == "signature"
    end
  end
end
