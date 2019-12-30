defmodule TeamCowboyGraphQL.Repos.Events do
  alias TeamCowboyGraphQL.Fetchers.Events, as: EventsFetcher
  alias TeamCowboyGraphQL.Savers.Events, as: EventsSaver
  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Events, as: EventsNormalizer

  def find(client, args) do
    client |> EventsFetcher.event_get(args) |> normalize
  end

  defp normalize({:ok, event}) do
    {:ok, event |> EventsNormalizer.normalize_team_event()}
  end

  defp normalize({:error, msg}) do
    {:error, msg}
  end
end
