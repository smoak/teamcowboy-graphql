defmodule TeamCowboyGraphQL.Client do
  defstruct public_api_key: nil,
            private_api_key: nil,
            auth: nil,
            endpoint: "https://api.teamcowboy.com/v1/"

  @type t :: %__MODULE__{
          public_api_key: binary,
          private_api_key: binary,
          auth: binary | nil,
          endpoint: binary
        }

  @spec new() :: t
  def new(), do: %__MODULE__{}

  @spec new(map()) :: t
  def new(%{access_token: auth, public_api_key: public_api_key, private_api_key: private_api_key}),
    do: %__MODULE__{auth: auth, public_api_key: public_api_key, private_api_key: private_api_key}

  @spec new(map()) :: t
  def new(%{access_token: auth}), do: %__MODULE__{auth: auth}

  @spec new(map()) :: t
  def new(%{public_api_key: public_api_key}), do: %__MODULE__{public_api_key: public_api_key}
end
