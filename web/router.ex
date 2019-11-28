defmodule ElixirHelper.Web.Router do
  @moduledoc """
  Main router of application
  Offer a ping to see is everything is running ok
  """
  use Plug.Router

  alias ElixirHelper.PingController, as: Ping
  alias ElixirHelper.VersionController, as: Version

  plug(:match)
  plug(ElixirHelper.Metrics.Instrumenter)
  plug(ElixirHelper.Metrics.Exporter)
  plug(:dispatch)

  get("/ping",      do: Ping.ping(conn))
  get("/flunk",     do: Ping.flunk(conn))
  get("/version",   do: Version.run(conn))

  forward("/api",       to: ElixirHelper.ApiRouter)
  forward("/gaming",    to: ElixirHelper.GamingRouter)

  match _ do
    send_resp(conn, 404, "oops")
  end
end
