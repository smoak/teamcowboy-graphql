defmodule TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Locations do
  alias TeamCowboyGraphQL.Data.TeamCowboy.Location

  @type location() :: map()

  @spec normalize_location(nil | location()) :: Location.t() | nil
  def normalize_location(nil), do: nil
  def normalize_location(location) when map_size(location) == 0, do: nil

  def normalize_location(location) when is_map(location) do
    %Location{
      location_id: location |> Map.get("locationId"),
      name: location |> Map.get("name"),
      address: location |> Map.get("address") |> Map.get("displaySingleLine"),
      google_maps_url: location |> Map.get("address") |> Map.get("googleMapsUrl"),
      google_maps_directions_url:
        location |> Map.get("address") |> Map.get("googleMapsDirectionsUrl"),
      is_public: location |> Map.get("visibility") == "public"
    }
  end

  def normalize_location(_), do: nil
end
