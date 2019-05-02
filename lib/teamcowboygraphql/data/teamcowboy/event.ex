defmodule TeamCowboyGraphQL.Data.TeamCowboy.Event do
  @typedoc """
  Type that represents an event in GraphQL form
  """

  alias TeamCowboyGraphQL.Data.TeamCowboy.Location

  defstruct event_id: nil,
            season_id: nil,
            season_name: nil,
            event_type: nil,
            status: nil,
            title: nil,
            start_timestamp: nil,
            end_timestamp: nil,
            location: nil,
            team_id: nil

  @type t(
          event_id,
          season_id,
          season_name,
          event_type,
          status,
          title,
          start_timestamp,
          end_timestamp,
          location,
          team_id
        ) :: %__MODULE__{
          event_id: event_id,
          season_id: season_id,
          season_name: season_name,
          event_type: event_type,
          status: status,
          title: title,
          start_timestamp: start_timestamp,
          end_timestamp: end_timestamp,
          location: location,
          team_id: team_id
        }

  @type t :: %__MODULE__{
          event_id: integer,
          season_id: integer,
          season_name: String.t(),
          event_type: String.t(),
          status: String.t(),
          title: String.t(),
          start_timestamp: integer,
          end_timestamp: integer,
          location: Location.t(),
          team_id: integer
        }
end
