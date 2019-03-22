defmodule TeamCowboyGraphQL.Data.Normalization.TeamCowboy.UsersTest do
  use ExUnit.Case

  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Users
  alias TeamCowboyGraphQL.Data.TeamCowboy.User

  describe ".normalize_user" do
    test "it normalizes a user" do
      teamcowboy_user = %{
        "userId" => 1,
        "fullName" => "Test User",
        "firstName" => "Test",
        "lastName" => "User",
        "displayName" => "Test",
        "emailAddress1" => "test@example.com",
        "profilePhoto" => %{
          "fullUrl" => "https://picsum.photos/1024/768",
          "smallUrl" => "https://picsum.photos/200/300",
          "thumbUrl" => "https://picsum.photos/80"
        }
      }

      normalized_user = teamcowboy_user |> Users.normalize_user()

      assert normalized_user == %User{
               user_id: 1,
               full_name: "Test User",
               first_name: "Test",
               last_name: "User",
               display_name: "Test",
               email_address1: "test@example.com",
               profile_photo_full_url: "https://picsum.photos/1024/768",
               profile_photo_small_url: "https://picsum.photos/200/300",
               profile_photo_thumbnail_url: "https://picsum.photos/80"
             }
    end
  end
end
