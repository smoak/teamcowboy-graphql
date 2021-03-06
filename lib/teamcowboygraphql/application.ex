defmodule TeamCowboyGraphQL.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Telemetry supervisor
      TeamCowboyGraphQLWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, [name: TeamCowboyGraphQL.PubSub, adapter: Phoenix.PubSub.PG2]},
      # Start the Endpoint (http/https)
      TeamCowboyGraphQLWeb.Endpoint

      # Starts a worker by calling: TeamCowboyGraphQL.Worker.start_link(arg)
      # {TeamCowboyGraphQL.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TeamCowboyGraphQL.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TeamCowboyGraphQLWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
