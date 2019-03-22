defmodule TeamCowboyGraphQL.Data.TeamCowboy.User do
  @typedoc """
  Type that represents a user in GraphQL form
  """

  defstruct user_id: nil,
            first_name: nil,
            last_name: nil,
            full_name: nil,
            display_name: nil,
            email_address1: nil,
            profile_photo_full_url: nil,
            profile_photo_small_url: nil,
            profile_photo_thumbnail_url: nil

  @type t(
          user_id,
          first_name,
          last_name,
          full_name,
          display_name,
          email_address1,
          profile_photo_full_url,
          profile_photo_small_url,
          profile_photo_thumbnail_url
        ) :: %__MODULE__{
          user_id: user_id,
          first_name: first_name,
          last_name: last_name,
          full_name: full_name,
          display_name: display_name,
          email_address1: email_address1,
          profile_photo_full_url: profile_photo_full_url,
          profile_photo_small_url: profile_photo_small_url,
          profile_photo_thumbnail_url: profile_photo_thumbnail_url
        }

  @type t :: %__MODULE__{
          user_id: integer,
          first_name: String.t(),
          last_name: String.t(),
          full_name: String.t(),
          display_name: String.t(),
          email_address1: String.t(),
          profile_photo_full_url: String.t(),
          profile_photo_small_url: String.t(),
          profile_photo_thumbnail_url: String.t()
        }
end
