defmodule TeamCowboyGraphQLWeb.Schema do
  use Absinthe.Schema

  alias TeamCowboyGraphQLWeb.Resolvers

  import_types(Absinthe.Type.Custom)

  @desc "A team"
  object :team do
    field(:team_id, non_null(:integer))
    field(:name, non_null(:string))
    field(:short_name, non_null(:string))
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
    field(:season_name, non_null(:string))
    field(:event_type, non_null(:string))
    field(:status, non_null(:string))
    field(:title, non_null(:string))
    field(:location, :location)
    field(:start_timestamp, :integer)
    field(:end_timestamp, :integer)
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
      arg(:team_id, :integer)

      resolve(&Resolvers.Events.list/3)
    end
  end

  mutation(name: "Mutation") do
    @desc "Create a user token"
    field :create_user_token, type: :user_token do
      arg(:username, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.Users.create_token/3)
    end
  end
end
