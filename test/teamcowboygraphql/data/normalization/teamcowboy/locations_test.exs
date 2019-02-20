defmodule TeamCowboyGraphQL.Data.Normalization.TeamCowboy.LocationsTest do
  use ExUnit.Case

  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Locations
  alias TeamCowboyGraphQL.Data.TeamCowboy.Location

  describe ".normalize_location" do
    test "it normalizes a location" do
      teamcowboy_location = %{
        "address" => %{
          "addressLine1" => "123 Main St",
          "addressLine2" => "",
          "city" => "Nowhere",
          "displayMultiLine" => "123 Main St\nNowhere, CA 12345",
          "displaySingleLine" => "123 Main St Nowhere, CA 12345",
          "googleMapsDirectionsUrl" => nil,
          "googleMapsUrl" => nil,
          "partOfTown" => "",
          "postalCode" => "12345",
          "stateProvince" => "CA"
        },
        "comments" => "comments",
        "lights" => %{
          "hasLights" => true,
          "lights" => "yes",
          "lightsDisplay" => "Yes"
        },
        "locationId" => 330,
        "name" => "Test location",
        "surface" => %{
          "showType" => true,
          "type" => "ice",
          "typeDisplay" => "Ice"
        },
        "visibility" => "public",
        "visibilityDisplay" => "Public/shared"
      }

      normalized_location = Locations.normalize_location(teamcowboy_location)

      assert normalized_location == %Location{
               location_id: 330,
               name: "Test location",
               address: "123 Main St Nowhere, CA 12345",
               google_maps_url: nil,
               google_maps_directions_url: nil,
               is_public: true
             }
    end
  end
end
