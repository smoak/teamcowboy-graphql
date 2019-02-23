defmodule TeamCowboyGraphQL.Client do
  defstruct api_key: nil, auth: nil, endpoint: "https://api.teamcowboy.com/v1/"

  @type t :: %__MODULE__{api_key: binary, auth: binary | nil, endpoint: binary}

  @spec new() :: t
  def new(), do: %__MODULE__{}

  @spec new(map()) :: t
  def new(%{access_token: auth, api_key: api_key}), do: %__MODULE__{auth: auth, api_key: api_key}

  @spec new(map()) :: t
  def new(%{access_token: auth}), do: %__MODULE__{auth: auth}

  @spec new(map()) :: t
  def new(%{api_key: api_key}), do: %__MODULE__{api_key: api_key}
end
