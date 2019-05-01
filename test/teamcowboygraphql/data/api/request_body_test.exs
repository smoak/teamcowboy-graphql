defmodule TeamCowboyGraphQL.Data.Api.RequestBodyTest do
  use ExUnit.Case

  alias TeamCowboyGraphQL.Data.Api.RequestBody

  describe ".create" do
    test "it generates a uri encoded body with the api_key" do
      body =
        RequestBody.create("test_api_key", "POST", "Auth_GetUserToken", %{
          username: "test",
          password: "test"
        })

      assert body =~ "api_key=test_api_key"
    end

    test "it generates a uri encoded body with the api method" do
      body =
        RequestBody.create("test_api_key", "POST", "Auth_GetUserToken", %{
          username: "test",
          password: "test"
        })

      assert body =~ "method=Auth_GetUserToken"
    end

    test "it generates a uri encoded body with a nonce key" do
      body =
        RequestBody.create("test_api_key", "POST", "Auth_GetUserToken", %{
          username: "test",
          password: "test"
        })

      assert body =~ "nonce="
    end

    test "it generates a uri encoded body with the password" do
      body =
        RequestBody.create("test_api_key", "POST", "Auth_GetUserToken", %{
          username: "test",
          password: "test"
        })

      assert body =~ "password=test"
    end

    test "it generates a uri encoded body with a sig key" do
      body =
        RequestBody.create("test_api_key", "POST", "Auth_GetUserToken", %{
          username: "test",
          password: "test"
        })

      assert body =~ "sig="
    end

    test "it generates a uri encoded body with a timestamp key" do
      body =
        RequestBody.create("test_api_key", "POST", "Auth_GetUserToken", %{
          username: "test",
          password: "test"
        })

      assert body =~ "timestamp="
    end

    test "it generates a uri encoded body with the username" do
      body =
        RequestBody.create("test_api_key", "POST", "Auth_GetUserToken", %{
          username: "test",
          password: "test"
        })

      assert body =~ "username=test"
    end
  end
end
