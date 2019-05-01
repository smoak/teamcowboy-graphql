defmodule TeamCowboyGraphQL.Data.Api.RequestParametersTest do
  use ExUnit.Case

  alias TeamCowboyGraphQL.Data.Api.RequestParameters

  describe ".create" do
    test "it generates a map with the correct api_key" do
      params =
        RequestParameters.create("POST", "Auth_GetUserToken", %{
          username: "test",
          password: "test"
        })

      assert Map.get(params, :api_key) == "foo"
    end
  end
end
