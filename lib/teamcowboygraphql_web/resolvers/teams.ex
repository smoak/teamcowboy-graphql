defmodule TeamCowboyGraphQLWeb.Resolvers.Teams do
  def list(_parent, args, _resolution) do
    args |> IO.inspect
    {:ok, []}
  end
end