defmodule TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Teams do
  alias TeamCowboyGraphQL.Data.TeamCowboy.Team

  @type team() :: map()

  @spec normalize_user_teams(list(team())) :: list(Team.t())
  def normalize_user_teams(teams) do
    teams |> Enum.map(&normalize_user_team/1)
  end

  @spec normalize_user_team(team()) :: Team.t()
  def normalize_user_team(team) do
    photo_urls = team |> Map.get("teamPhoto", %{})

    %Team{
      team_id: team |> Map.get("teamId"),
      name: team |> Map.get("name"),
      short_name: team |> Map.get("shortName"),
      photo_full_url: photo_urls |> Map.get("fullUrl"),
      photo_small_url: photo_urls |> Map.get("smallUrl"),
      photo_thumbnail_url: photo_urls |> Map.get("thumbUrl")
    }
  end
end
