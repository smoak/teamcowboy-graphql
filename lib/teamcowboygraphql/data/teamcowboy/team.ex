defmodule TeamCowboyGraphQL.Data.TeamCowboy.Team do
  @typedoc """
  Type that represents a team in GraphQL form
  """

  defstruct team_id: nil,
            name: nil,
            short_name: nil

  @type t(team_id, name, short_name) :: %__MODULE__{
          team_id: team_id,
          name: name,
          short_name: short_name
        }

  @type t :: %__MODULE__{
          team_id: integer,
          name: String.t(),
          short_name: String.t()
        }
end
