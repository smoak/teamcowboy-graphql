defmodule TeamCowboyGraphQL.Data.TeamCowboy.Team do
  @typedoc """
  Type that represents a team in GraphQL form
  """

  defstruct team_id: nil,
            name: nil,
            short_name: nil,
            photo_full_url: nil,
            photo_thumbnail_url: nil,
            photo_small_url: nil

  @type t(team_id, name, short_name, photo_full_url, photo_thumbnail_url, photo_small_url) ::
          %__MODULE__{
            team_id: team_id,
            name: name,
            short_name: short_name,
            photo_full_url: photo_full_url,
            photo_thumbnail_url: photo_thumbnail_url,
            photo_small_url: photo_small_url
          }

  @type t :: %__MODULE__{
          team_id: integer,
          name: String.t(),
          short_name: String.t(),
          photo_full_url: String.t(),
          photo_thumbnail_url: String.t(),
          photo_small_url: String.t()
        }
end
