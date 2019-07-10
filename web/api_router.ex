defmodule ElixirHelper.ApiRouter do
  @moduledoc """
  Api router
  Just call to Controller
  """
  import Plug.Conn
  use Plug.Router
  require Logger

  alias ElixirHelper.Api.Controller, as: Controller

  plug(:match)
  plug(:dispatch)

  get "/laliga" do 
    Logger.info("Getting /api/laliga")

    conn = Plug.Conn.fetch_query_params(conn)
    Controller.run(conn)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end

end
