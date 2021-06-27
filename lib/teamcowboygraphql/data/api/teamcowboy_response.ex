defmodule TeamCowboyGraphQL.Data.Api.TeamCowboyResponse do
  def process({200, %{"body" => body}, _}), do: {:ok, body}

  def process({403, _, _}), do: {:error, "Forbidden"}

  def process({400, %{"body" => %{"error" => %{"message" => error_message}}}, _}),
    do: {:error, error_message}
end
