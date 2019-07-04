defmodule ElixirHelper do
  @moduledoc """
  Start application and setup metrics
  """

  use Application

  alias Plug.Cowboy
  alias ElixirHelper.VersionController
  alias ElixirHelper.Metrics
  alias ElixirHelper.Web.Router
  alias ElixirHelper.Metrics.{Exporter, Instrumenter}

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Metrics.setup()
    Exporter.setup()
    Instrumenter.setup()

    Metrics.inc(:version, labels: [VersionController.get_commit_version()])

    children = [
      Cowboy.child_spec(
        scheme: :http,
        plug: Router,
        options: [port: Application.get_env(:elixir_helper, :port)]
      )
    ]

    opts = [strategy: :one_for_one, name: ElixirHelper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
