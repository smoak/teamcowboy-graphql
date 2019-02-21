defmodule TeamCowboyGraphQL.Data.TeamCowboy.UserToken do
  @typedoc """
  Type that represents a user token in GraphQL form
  """

  defstruct token: nil

  @type t(token) :: %__MODULE__{token: token}

  @type t :: %__MODULE__{token: String.t()}
end
