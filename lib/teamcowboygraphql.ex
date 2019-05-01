defmodule TeamCowboyGraphQL do
  use HTTPoison.Base
  alias TeamCowboyGraphQL.Client

  @default_headers [{"User-agent", "teamcowboy-graphql"}]
  @default_options [follow_redirect: true]

  @spec process_response_body(binary) :: term
  def process_response_body(""), do: nil
  def process_response_body(body), do: Poison.decode!(body)

  @spec process_response(HTTPoison.Response.t()) :: {integer, any, HTTPoison.Response.t()}
  def process_response(%HTTPoison.Response{status_code: status_code, body: body} = resp),
    do: {status_code, body, resp}

  @spec post(Client.t(), binary, keyword) :: {integer, any, HTTPoison.Response.t()}
  def post(client, body \\ "", headers \\ [{"Content-Type", "application/x-www-form-urlencoded"}]) do
    raw_request(:post, client.endpoint, body, headers)
  end

  @spec get(Client.t(), binary, keyword) :: {integer, any, HTTPoison.Response.t()}
  def get(client, headers \\ [], params \\ nil) do
    raw_request(:get, client.endpoint, "", headers, params: params)
  end

  defp raw_request(method, url, body \\ "", headers \\ [], options \\ []) do
    method
    |> request!(url, body, @default_headers ++ headers, @default_options ++ options)
  end
end
