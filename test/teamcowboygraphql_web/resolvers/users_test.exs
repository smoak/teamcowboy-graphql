defmodule TeamCowboyGraphQLWeb.Resolvers.UsersTest do
  use ExUnit.Case

  alias TeamCowboyGraphQL.Data.TeamCowboy.UserToken
  alias TeamCowboyGraphQLWeb.Resolvers.Users

  describe(".create_token") do
    test(
      "when a token is returned it should return a UserToken struct with the token populated"
    ) do
      parent = nil
      params = %{username: "test", password: "test"}
      context = %{context: %{client: "stubbed"}}
      auth_client = TeamCowboyGraphQL.Support.Stub.Client.Auth

      result = Users.create_token(parent, params, context, auth_client)

      assert result == {:ok, %UserToken{token: "test"}}
    end

    test("when there is an error it should return an error") do
      parent = nil
      params = %{username: "test", password: "test"}
      context = %{context: %{client: "stubbed"}}
      auth_client = TeamCowboyGraphQL.Support.Stub.Client.AuthWithError

      result = Users.create_token(parent, params, context, auth_client)

      assert result == {:error, "nope"}
    end
  end

  describe(".get") do
    test("with no authorization header it should produce an error") do
      parent = nil
      params = nil
      context = %{context: %{client: %TeamCowboyGraphQL.Client{auth: nil}}}

      result = Users.get(parent, params, context)

      assert result == {:error, "No authorization header"}
    end
  end
end
