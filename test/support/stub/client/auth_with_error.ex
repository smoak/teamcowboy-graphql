defmodule TeamCowboyGraphQL.Support.Stub.Client.AuthWithError do
  def get_user_token(_client, _params) do
    {:error, "nope"}
  end
end
