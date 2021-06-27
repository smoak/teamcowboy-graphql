defmodule TeamCowboyGraphQLWeb.Loaders.Teams do
  alias TeamCowboyGraphQLWeb.Resolvers.Teams
  require Logger

  def data(context) do
    Dataloader.KV.new(fn batch_key, ids ->
      fetch(batch_key, ids, context)
    end)
  end

  # batch_key, args
  def fetch({:team, _}, ids, context) do
    Logger.debug(fn -> "Fetching a team from the KV Dataloader." end)

    ids
    |> Enum.reduce(%{}, fn id, result ->
      # we have to make sure that we return a map keyed by the args we got
      {:ok, team} = find_team(id, id, context)
      Map.put(result, id, team)
    end)
  end

  defp find_team(event, id, context) do
    Logger.debug(fn -> "Cache miss for teamId: #{id}, so finding via resolver" end)
    Teams.by_id(event, %{id: id}, %{context: context})
  end
end
