defmodule TeamCowboyGraphQL.Client.Users do
  alias TeamCowboyGraphQL.Data.TeamCowboy.UserToken

  @spec authenticate(String.t(), String.t()) :: UserToken.t()
  def authenticate(_username, _password) do
    {:ok, %UserToken{token: "FIXME"}}
  end
end
