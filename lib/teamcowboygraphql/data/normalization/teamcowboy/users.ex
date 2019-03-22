defmodule TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Users do
  alias TeamCowboyGraphQL.Data.TeamCowboy.User

  @type user() :: map()

  @spec normalize_user(user()) :: User.t()
  def normalize_user(user) do
    %User{
      user_id: user |> Map.get("userId"),
      first_name: user |> Map.get("firstName"),
      last_name: user |> Map.get("lastName"),
      full_name: user |> Map.get("fullName"),
      display_name: user |> Map.get("displayName"),
      email_address1: user |> Map.get("emailAddress1"),
      profile_photo_full_url: user |> Map.get("profilePhoto") |> Map.get("fullUrl"),
      profile_photo_small_url: user |> Map.get("profilePhoto") |> Map.get("smallUrl"),
      profile_photo_thumbnail_url: user |> Map.get("profilePhoto") |> Map.get("thumbUrl")
    }
  end
end
