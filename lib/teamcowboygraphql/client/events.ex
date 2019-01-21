defmodule TeamCowboyGraphQL.Client.Events do
  alias TeamCowboyGraphQL.Data.Api.ApiRequest
  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy

  def list(user_token, team_id) do
    {:ok, events} = ApiRequest.execute(user_token, "Team_GetEvents", %{teamId: team_id})

    events |> TeamCowboy.normalize_team_events()

    # events
    # |> Enum.map(fn e ->
    #   %{
    #     event_id: e |> Map.get("eventId"),
    #     team: e |> Map.get("team"),
    #     season_id: e |> Map.get("seasonId"),
    #     season_name: e |> Map.get("seasonName"),
    #     event_type: e |> Map.get("eventType"),
    #     status: e |> Map.get("status"),
    #     title: e |> Map.get("oneLineDisplay"),
    #     start_timestamp:
    #       e
    #       |> Map.get("dateTimeInfo")
    #       |> Map.get("startDateTimeUtc")
    #       |> String.split(" ")
    #       |> Enum.join("T")
    #       |> String.pad_trailing(20, "Z")
    #       |> DateTime.from_iso8601()
    #       |> DateTime.to_unix()
    #   }
    # end)
  end
end
