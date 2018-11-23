defmodule TeamCowboyGraphQLWeb.Resolvers.Teams do
  def list(_parent, args, %{context: %{user_token: user_token}}) do
    {:ok, []}
  end

  def list(_parent, _args, %{context: %{}}) do
    {:error, "No authorization header"}
  end
end
