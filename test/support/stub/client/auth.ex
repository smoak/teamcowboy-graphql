defmodule TeamCowboyGraphQL.Support.Stub.Client.Auth do
  def get_user_token(_client, _params) do
    {:ok, %{"token" => "test", "userId" => "test"}}
  end
end
