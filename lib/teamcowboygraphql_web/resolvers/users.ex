defmodule TeamCowboyGraphQLWeb.Resolvers.Users do
  alias TeamCowboyGraphQL.Data.TeamCowboy.UserToken
  alias TeamCowboyGraphQL.Data.TeamCowboy.User
  alias TeamCowboyGraphQL.Client.Auth
  alias TeamCowboyGraphQL.Client.User, as: UserClient
  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Users
  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Events
  require Logger

  @type context :: %{context: %{client: TeamCowboyGraphQL.Client.t()}}

  @spec create_token(map(), %{username: String.t(), password: String.t()}, context) ::
          {:ok, UserToken.t()} | {:error, binary}
  def create_token(
        _parent,
        %{username: _, password: _} = params,
        %{context: %{client: client}},
        auth_client \\ Auth
      ) do
    case auth_client.get_user_token(client, params) do
      {:ok, %{"token" => token, "userId" => _}} -> {:ok, %UserToken{token: token}}
      {:error, msg} -> {:error, msg}
      _ -> {:error, "Unknown error"}
    end
  end

  @spec get(map(), map(), context) :: {:ok, User.t()}
  def get(_parent, _params, %{context: %{client: %TeamCowboyGraphQL.Client{auth: nil}}}) do
    {:error, "No authorization header"}
  end

  def get(_parent, _params, %{context: %{client: client}}) do
    case UserClient.get(client) do
      {:ok, raw_user} -> {:ok, Users.normalize_user(raw_user)}
      {:error, msg} -> {:error, msg}
      _ -> {:error, "Unknown error"}
    end
  end

  @spec events(map(), map(), context) :: {:ok, list(Event.t())} | {:error, binary}
  def events(_parent, _params, %{context: %{client: %TeamCowboyGraphQL.Client{auth: nil}}}) do
    {:error, "No authorization header"}
  end

  def events(_parent, params, %{context: %{client: client}} = res) do
    include_rsvp_info =
      res
      |> Absinthe.Resolution.project()
      |> Enum.any?(fn %{name: name} -> name == "viewerRsvpStatus" end)

    case UserClient.get_team_events(
           client,
           params |> Map.merge(%{include_rsvp_info: include_rsvp_info})
         ) do
      {:ok, raw_events} -> {:ok, Events.normalize_team_events(raw_events)}
      {:error, msg} -> {:error, msg}
      _ -> {:error, "Unknown error"}
    end
  end
end
