defmodule TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Events do
  alias TeamCowboyGraphQL.Data.TeamCowboy.Event

  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Locations

  @type event() :: map()

  @spec normalize_team_events(list(event())) :: list(Event.t())
  def normalize_team_events(events) do
    events |> Enum.map(&normalize_team_event/1)
  end

  @spec normalize_team_event(event()) :: Event.t()
  def normalize_team_event(event) do
    %Event{
      event_id: event |> Map.get("eventId"),
      season_id: event |> Map.get("seasonId"),
      season_name: event |> Map.get("seasonName"),
      event_type: event |> Map.get("eventType"),
      status: event |> Map.get("status"),
      title: event |> Map.get("titleFull") |> sanitize_title(),
      location: Locations.normalize_location(event |> Map.get("location")),
      start_timestamp:
        event
        |> Map.get("dateTimeInfo")
        |> Map.get("startDateTimeUtc")
        |> normalize_date_time_info(),
      end_timestamp:
        event
        |> Map.get("dateTimeInfo")
        |> Map.get("endDateTimeUtc")
        |> normalize_date_time_info(),
      team_id: event |> Map.get("team") |> Map.get("teamId")
    }
  end

  defp normalize_date_time_info(nil), do: nil

  defp normalize_date_time_info(date_time) do
    {:ok, date, _} =
      date_time
      |> String.split(" ")
      |> Enum.join("T")
      |> String.pad_trailing(20, "Z")
      |> DateTime.from_iso8601()

    date |> DateTime.to_unix()
  end

  @spec sanitize_title(String.t()) :: String.t()
  defp sanitize_title(title) do
    title
    |> String.replace("&nbsp;", " ")
    |> String.replace("&amp;", "&")
  end
end
