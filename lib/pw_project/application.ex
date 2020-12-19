defmodule PwProject.Application do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: PwProject.Router, options: [port: cowboy_port()]}
    ]

    opts = [strategy: :one_for_one, name: PwProject.Supervisor]

    Logger.info("Starting application at http://127.0.0.1:#{cowboy_port()}... ")

    Supervisor.start_link(children, opts)
  end

  defp cowboy_port, do: Application.get_env(:pw_project, :cowboy_port, 8080)
end
