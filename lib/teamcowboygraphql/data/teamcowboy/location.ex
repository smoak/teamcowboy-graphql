defmodule TeamCowboyGraphQL.Data.TeamCowboy.Location do
  @typedoc """
  Type that represents a location in GraphQL form
  """

  defstruct location_id: nil,
            name: nil,
            address: nil,
            google_maps_url: nil,
            google_maps_directions_url: nil,
            is_public: nil

  @type t(
          location_id,
          name,
          address,
          google_maps_url,
          google_maps_directions_url,
          is_public
        ) :: %__MODULE__{
          location_id: location_id,
          name: name,
          address: address,
          google_maps_url: google_maps_url,
          google_maps_directions_url: google_maps_directions_url,
          is_public: is_public
        }

  @type t :: %__MODULE__{
          location_id: integer,
          name: String.t(),
          address: String.t(),
          google_maps_url: String.t(),
          google_maps_directions_url: String.t(),
          is_public: boolean
        }
end
