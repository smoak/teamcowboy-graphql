defmodule TeamCowboyGraphQL.Data.Normalization.TeamCowboy.EventsTest do
  use ExUnit.Case

  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Events
  alias TeamCowboyGraphQL.Data.TeamCowboy.Event

  describe ".normalize_team_event" do
    test "it normalizes an event" do
      teamcowboy_event = %{
        "eventId" => 1,
        "seasonId" => 5,
        "seasonName" => "test",
        "eventType" => "foo",
        "status" => "bar",
        "titleFull" => "TITLE",
        "dateTimeInfo" => %{
          "startDateTimeUtc" => "2019-02-20 07:16:49",
          "endDateTimeUtc" => "2019-02-20 07:17:05"
        },
        "location" => nil
      }

      normalized_event = Events.normalize_team_event(teamcowboy_event)

      assert normalized_event == %Event{
               event_id: 1,
               season_id: 5,
               season_name: "test",
               event_type: "foo",
               status: "bar",
               title: "TITLE",
               start_timestamp: 1_550_647_009,
               end_timestamp: 1_550_647_025
             }
    end
  end

  describe ".normalize_team_events" do
    test "it normalizes the same number of events as input" do
      teamcowboy_event1 = %{
        "eventId" => 1,
        "seasonId" => 5,
        "seasonName" => "test",
        "eventType" => "foo",
        "status" => "bar",
        "titleFull" => "TITLE",
        "dateTimeInfo" => %{
          "startDateTimeUtc" => "2019-02-20 07:16:49",
          "endDateTimeUtc" => "2019-02-20 07:17:05"
        }
      }

      teamcowboy_event2 = %{
        "eventId" => 2,
        "seasonId" => 5,
        "seasonName" => "test",
        "eventType" => "foo",
        "status" => "bar",
        "titleFull" => "TITLE",
        "dateTimeInfo" => %{
          "startDateTimeUtc" => "2019-02-20 07:16:49",
          "endDateTimeUtc" => "2019-02-20 07:17:05"
        }
      }

      normalized_events = Events.normalize_team_events([teamcowboy_event1, teamcowboy_event2])

      assert length(normalized_events) == 2
    end
  end
end
