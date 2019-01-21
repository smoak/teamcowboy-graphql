defmodule TeamCowboyGraphQL.Client.Events do
  alias TeamCowboyGraphQL.Data.Api.ApiRequest

  def list(user_token, team_id) do
    {:ok, events} = ApiRequest.execute(user_token, "Team_GetEvents", %{teamId: team_id})

    events
    |> Enum.map(fn e ->
      %{
        event_id: e |> Map.get("eventId"),
        team: e |> Map.get("team"),
        season_id: e |> Map.get("seasonId"),
        season_name: e |> Map.get("seasonName"),
        event_type: e |> Map.get("eventType"),
        status: e |> Map.get("status"),
        title: e |> Map.get("oneLineDisplay"),
        # \"dateTimeInfo\":{\"timezoneId\":\"US\\/Pacific\",\"startDateLocal\":\"2019-01-21\",\"startTimeLocal\":\"21:10:00\",\"startDateTimeLocal\":\"2019-01-21 21:10:00\",\"startDateLocalDisplay\":\"Jan 21, 2019\",\"startTimeLocalDisplay\":\"9:10pm\",\"startDateTimeLocalDisplay\":\"Jan 21, 2019 9:10pm\",\"startDateTimeUtc\":\"2019-01-22 05:10:00\",\"startTimeTBD\":false,\"endDateLocal\":\"2019-01-21\",\"endTimeLocal\":\"23:10:00\",\"endDateTimeLocal\":\"2019-01-21 23:10:00\",\"endDateLocalDisplay\":\"Jan 21, 2019\",\"endTimeLocalDisplay\":\"\",\"endDateTimeLocalDisplay\":\"Jan 21, 2019 \",\"endDateTimeUtc\":\"2019-01-22 07:10:00\",\"endTimeTBD\":false,\"inPast\":false,\"inFuture\":true
        start_time:
          e
          |> Map.get("dateTimeInfo")
          |> Map.get("startDateTimeUtc")
          |> String.split(" ")
          |> Enum.join("T")
          |> String.pad_trailing(20, "Z")
      }
    end)
  end
end
