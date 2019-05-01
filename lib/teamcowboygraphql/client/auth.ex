defmodule TeamCowboyGraphQL.Client.Auth do
  import TeamCowboyGraphQL
  alias TeamCowboyGraphQL.Client
  alias TeamCowboyGraphQL.Data.Api.RequestParameters

  @type auth :: %{username: binary, password: binary}

  @spec get_user_token(Client.t(), auth) :: map()
  def get_user_token(client \\ %Client{}, auth) do
    body = RequestParameters.create("POST", "Auth_GetUserToken", auth) |> URI.encode_query()

    client |> post(body) |> process_teamcowboy_response
  end

  defp process_teamcowboy_response({200, %{"body" => body}, _}), do: {:ok, body}

  defp process_teamcowboy_response(
         {400, %{"body" => %{"error" => %{"message" => error_message}}}, _}
       ) do
    {:error, error_message}
  end
end
