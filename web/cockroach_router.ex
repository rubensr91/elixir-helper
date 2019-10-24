defmodule ElixirHelper.CockroachRouter do
  @moduledoc """
  CockroachRouter
  Just call to CockroachController
  """
  import Plug.Conn
  use Plug.Router
  require Logger

  alias ElixirHelper.CockroachController, as: CockroachController

  plug(:match)
  plug(:dispatch)

  get "/sentence" do
    conn = Plug.Conn.fetch_query_params(conn)
    CockroachController.sentence(conn)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end

end
