defmodule TeamCowboyGraphQL.Test.Stub.Auth do
  def get_user_token(_client, _params) do
    {:ok, %{"token" => "test", "userId" => "test"}}
  end
end