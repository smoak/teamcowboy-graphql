defmodule TeamCowboyGraphQLWeb.Resolvers.UsersTest do
  use ExUnit.Case

  alias TeamCowboyGraphQL.Data.TeamCowboy.UserToken
  alias TeamCowboyGraphQLWeb.Resolvers.Users

  describe(".create_token") do
    test("when a token is returned") do
      parent = nil
      params = %{username: "test", password: "test"}
      context = %{context: %{client: "stubbed"}}
      result = Users.create_token(parent, params, context)

      assert result == {:ok, %UserToken{token: "test"}}
    end
  end
end