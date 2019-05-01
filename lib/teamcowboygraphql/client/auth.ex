defmodule TeamCowboyGraphQL.Client.Auth do
  import TeamCowboyGraphQL
  alias TeamCowboyGraphQL.Client
  alias TeamCowboyGraphQL.Data.Api.RequestBody

  @type auth :: %{username: binary, password: binary}

  @spec get_user_token(Client.t(), auth) :: map()
  def get_user_token(client \\ %Client{}, auth) do
    body = client |> RequestBody.create("POST", "Auth_GetUserToken", auth)

    client |> post(body) |> process_teamcowboy_response
  end

  defp process_teamcowboy_response({200, %{"body" => body}, _}), do: {:ok, body}

  defp process_teamcowboy_response({400, %{"body" => %{"error" => error}}, _}) do
    {:error, error |> Map.get("message")}
  end
end
