defmodule TeamCowboyGraphQL.ClientTest do
  use ExUnit.Case

  alias TeamCowboyGraphQL.Client

  describe ".new" do
    test "it creates a module" do
      client = Client.new()

      assert client
    end

    test "it can accept an access_token" do
      client = Client.new(%{access_token: "test"})

      assert client.auth == "test"
    end

    test "it can accept a public_api_key" do
      client = Client.new(%{public_api_key: "test" })

      assert client.public_api_key == "test"
    end

    test "it can accept access_token, public_api_key, private_api_key" do
      client = Client.new(%{access_token: "access_token", public_api_key: "public_api_key", private_api_key: "private_api_key" })

      assert client.auth == "access_token"
      assert client.public_api_key == "public_api_key"
      assert client.private_api_key == "private_api_key"
    end
  end
end