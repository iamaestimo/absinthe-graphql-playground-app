defmodule Wendigo.Application do
  @moduledoc false
  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    Logger.info("Welcome to Project Wendigo")

    children = [
      WendigoWeb.Telemetry,
      Wendigo.Repo,
      {DNSCluster, query: Application.get_env(:wendigo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Wendigo.PubSub},
      WendigoWeb.Endpoint
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Wendigo.Supervisor)
  end

  # Tell Phoenix to update the endpoint configuration whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WendigoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
