defmodule TeamCowboyGraphQL.Data.Normalization.TeamCowboy.TeamsTest do
  use ExUnit.Case

  alias TeamCowboyGraphQL.Data.Normalization.TeamCowboy.Teams
  alias TeamCowboyGraphQL.Data.TeamCowboy.Team

  describe ".normalize_user_team" do
    test "it normalizes a team" do
      teamcowboy_team = %{
        "teamId" => 1,
        "name" => "test team",
        "shortName" => "test"
      }

      normalized_team = Teams.normalize_user_team(teamcowboy_team)

      assert normalized_team == %Team{team_id: 1, name: "test team", short_name: "test"}
    end
  end

  describe ".normalize_user_teams" do
    test "it normalizes the same number of teams as input" do
      teamcowboy_teams = [
        %{
          "teamId" => 1,
          "name" => "test team",
          "shortName" => "test"
        },
        %{
          "teamId" => 2,
          "name" => "test team 2",
          "shortName" => "test2"
        }
      ]

      normalized_teams = Teams.normalize_user_teams(teamcowboy_teams)

      assert length(normalized_teams) == 2
    end
  end
end
