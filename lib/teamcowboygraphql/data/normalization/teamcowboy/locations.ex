defmodule TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Locations do
  alias TeamCowboyGraphQL.Data.TeamCowboy.Location

  @type location() :: map()

  @spec normalize_location(nil) :: nil
  def normalize_location(nil), do: nil

  @spec normalize_location(location()) :: Location.t()
  def normalize_location(location) do
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
end
