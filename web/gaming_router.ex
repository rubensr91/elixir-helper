defmodule ElixirHelper.GamingRouter do
  @moduledoc """
  GamingRouter
  Just call to Controller
  """
  import Plug.Conn
  use Plug.Router
  require Logger

  alias ElixirHelper.Gaming.Controller, as: Controller

  plug(:match)
  plug(:dispatch)

  get "/v1/player/login" do
    Logger.info("Getting /v1/player/login")

    conn = Plug.Conn.fetch_query_params(conn)
    Controller.login(conn)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end

end
