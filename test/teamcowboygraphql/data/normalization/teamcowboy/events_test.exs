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
        "rsvpInstances" => [
          %{
            "rsvpDetails" => %{
              "status" => "yes"
            }
          }
        ],
        "dateTimeInfo" => %{
          "startDateTimeUtc" => "2019-02-20 07:16:49",
          "endDateTimeUtc" => "2019-02-20 07:17:05"
        },
        "location" => nil,
        "team" => %{
          "teamId" => 5
        }
      }

      normalized_event = Events.normalize_team_event(teamcowboy_event)

      assert normalized_event == %Event{
               event_id: 1,
               season_id: 5,
               season_name: "test",
               event_type: "foo",
               status: "bar",
               title: "TITLE",
               viewer_rsvp_status: :yes,
               start_timestamp: 1_550_647_009,
               end_timestamp: 1_550_647_025,
               team_id: 5
             }
    end

    test "it replaces &nbsp; with a space in the title" do
      teamcowboy_event = %{
        "eventId" => 1,
        "seasonId" => 5,
        "seasonName" => "test",
        "eventType" => "foo",
        "status" => "bar",
        "titleFull" => "title&nbsp;full",
        "rsvpInstances" => [
          %{
            "rsvpDetails" => %{
              "status" => "yes"
            }
          }
        ],
        "dateTimeInfo" => %{
          "startDateTimeUtc" => "2019-02-20 07:16:49",
          "endDateTimeUtc" => "2019-02-20 07:17:05"
        },
        "location" => nil,
        "team" => %{
          "teamId" => 5
        }
      }

      title = teamcowboy_event |> Events.normalize_team_event() |> Map.get(:title)

      assert title == "title full"
    end

    test "it replaces &amp; in the title with a &" do
      teamcowboy_event = %{
        "eventId" => 1,
        "seasonId" => 5,
        "seasonName" => "test",
        "eventType" => "foo",
        "status" => "bar",
        "titleFull" => "title &amp; full",
        "rsvpInstances" => [
          %{
            "rsvpDetails" => %{
              "status" => "yes"
            }
          }
        ],
        "dateTimeInfo" => %{
          "startDateTimeUtc" => "2019-02-20 07:16:49",
          "endDateTimeUtc" => "2019-02-20 07:17:05"
        },
        "location" => nil,
        "team" => %{
          "teamId" => 5
        }
      }

      title = teamcowboy_event |> Events.normalize_team_event() |> Map.get(:title)

      assert title == "title & full"
    end

    test "it normalizes a Get_TeamEvents response" do
      response =
        "test/fixtures/normalization/Get_TeamEvents-response.json"
        |> File.read!()
        |> Poison.decode!()

      normalized_event = Events.normalize_team_event(response["body"] |> List.first())

      assert normalized_event == %Event{
               event_id: 1_785_791,
               season_id: 78028,
               season_name: "GSHL Spring 2021 Season",
               event_type: "game",
               status: "active",
               title: "Monarchs 5B (Away) vs. TBD",
               viewer_rsvp_status: :yes,
               start_timestamp: 1_621_916_700,
               end_timestamp: 1_621_923_900,
               team_id: 16461
             }
    end

    test "it normalizes an Event_Get response" do
      response =
        "test/fixtures/normalization/Event_Get-response.json"
        |> File.read!()
        |> Poison.decode!()

      normalized_event = Events.normalize_team_event(response["body"])

      assert normalized_event == %Event{
               event_id: 1_785_791,
               season_id: 78028,
               season_name: nil,
               event_type: "game",
               status: "active",
               title: "Monarchs 5B (Away) vs. TBD",
               viewer_rsvp_status: :yes,
               start_timestamp: 1_621_916_700,
               end_timestamp: 1_621_923_900,
               team_id: 16461
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
        "rsvpInstances" => [
          %{
            "rsvpDetails" => %{
              "status" => "yes"
            }
          }
        ],
        "dateTimeInfo" => %{
          "startDateTimeUtc" => "2019-02-20 07:16:49",
          "endDateTimeUtc" => "2019-02-20 07:17:05"
        },
        "team" => %{
          "teamId" => 5
        }
      }

      teamcowboy_event2 = %{
        "eventId" => 2,
        "seasonId" => 5,
        "seasonName" => "test",
        "eventType" => "foo",
        "status" => "bar",
        "titleFull" => "TITLE",
        "rsvpInstances" => [
          %{
            "rsvpDetails" => %{
              "status" => "yes"
            }
          }
        ],
        "dateTimeInfo" => %{
          "startDateTimeUtc" => "2019-02-20 07:16:49",
          "endDateTimeUtc" => "2019-02-20 07:17:05"
        },
        "team" => %{
          "teamId" => 6
        }
      }

      normalized_events = Events.normalize_team_events([teamcowboy_event1, teamcowboy_event2])

      assert length(normalized_events) == 2
    end
  end
end
