defmodule TeamCowboyGraphQLWeb.Schema do
  use Absinthe.Schema

  alias TeamCowboyGraphQLWeb.Resolvers

  import_types(Absinthe.Type.Custom)

  @desc "The RSVP status of a user"
  enum :rsvp_status do
    value(:yes, as: :yes, description: "Indicates the user will attend")
    value(:no, as: :no, description: "Indicates the user will not attend")
    value(:maybe, as: :maybe, description: "Indicates the user might attend")
    value(:available, as: :available, description: "Indicates the user is available to attend")
    value(:none, as: :none, description: "Indicates the user has not RSVPed")
  end

  @desc "A team"
  object :team do
    field(:team_id, non_null(:integer))
    field(:name, non_null(:string))
    field(:short_name, non_null(:string))
    field(:photo_full_url, :string)
    field(:photo_small_url, :string)
    field(:photo_thumbnail_url, :string)
  end

  @desc "A location"
  object :location do
    field(:location_id, non_null(:integer))
    field(:name, non_null(:string))
    field(:address, :string)
    field(:google_maps_url, :string)
    field(:google_maps_directions_url, :string)
    field(:is_public, non_null(:boolean))
  end

  @desc "An event"
  object :event do
    field(:event_id, non_null(:integer))
    field(:season_id, non_null(:integer))
    field(:season_name, :string)
    field(:event_type, non_null(:string))
    field(:status, non_null(:string))
    field(:title, non_null(:string))
    field(:location, :location)
    field(:start_timestamp, :integer)
    field(:end_timestamp, :integer)

    field(:viewer_rsvp_status, non_null(:rsvp_status)) do
      resolve(&Resolvers.ViewerRsvpStatus.from_event/3)
    end

    field(:team, non_null(:team)) do
      resolve(fn event, _, context ->
        Resolvers.Teams.by_id(event, %{id: event.team_id}, context)
      end)
    end
  end

  @desc "A user"
  object :user do
    field(:user_id, non_null(:integer))
    field(:first_name, non_null(:string))
    field(:last_name, non_null(:string))
    field(:full_name, non_null(:string))
    field(:display_name, non_null(:string))
    field(:email_address1, non_null(:string))
    field(:profile_photo_full_url, non_null(:string))
    field(:profile_photo_small_url, non_null(:string))
    field(:profile_photo_thumbnail_url, non_null(:string))

    field :events, non_null(list_of(:event)) do
      @desc "Whether or not to restrict the events retrieved only to those for teams on the user’s Dashboard."
      arg(:dashboard_only, :boolean, default_value: false)

      resolve(&Resolvers.Users.events/3)
    end
  end

  @desc "A user token"
  object :user_token do
    @desc "A unique token for the user matched. Tokens are 36-character, lower-cased GUIDs."
    field(:token, non_null(:string))
  end

  query(name: "Query") do
    @desc "Get teams for a user"
    field :teams, non_null(list_of(:team)) do
      @desc "Whether or not to restrict the teams retrieved only to those on the user’s Dashboard."
      arg(:dashboard_only, :boolean, default_value: false)

      resolve(&Resolvers.Teams.list/3)
    end

    @desc "Get events for a team"
    field :events, non_null(list_of(:event)) do
      @desc "Id of the team to retrieve events for."
      arg(:team_id, non_null(:integer))

      resolve(&Resolvers.Events.list/3)
    end

    @desc "Gets the current user"
    field :current_user, non_null(:user) do
      resolve(&Resolvers.Users.get/3)
    end

    @desc "Get a single event"
    field :event, :event do
      @desc "Id of the team to retrieve the event for."
      arg(:team_id, non_null(:integer))

      @desc "Id of the event to retrieve."
      arg(:event_id, non_null(:integer))

      resolve(&Resolvers.Events.get/3)
    end
  end

  mutation(name: "Mutation") do
    @desc "Create a user token"
    field :create_user_token, type: :user_token do
      arg(:username, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.Users.create_token/3)
    end

    @desc "RSVP to an event"
    field :save_rsvp, type: non_null(:event) do
      @desc "Id of the team that the event is associated with."
      arg(:team_id, non_null(:integer))

      @desc "Id of the event to rsvp to."
      arg(:event_id, non_null(:integer))

      @desc "The RSVP status to save."
      arg(:rsvp_status, non_null(:rsvp_status))

      @desc "RSVP comments."
      arg(:comments, :string)

      resolve(&Resolvers.Events.save_rsvp/3)
    end
  end
end
