defmodule ElixirHelper.Api.Controller do
  @moduledoc """
  """
  import Plug.Conn
  require Logger

  alias ElixirHelper.Api.Logic

  @spec run(Plug.Conn.t(), any) :: Plug.Conn.t()
  def run(conn, _params \\ []) do
    conn.query_string
    |> Logic.run()
    |> response(conn)
  end

  @spec response(Tuple, Plug.Conn.t()) :: Plug.Conn.t()
  def response({:ok, data}, conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, data)
  end
  def response({:error, reason}, conn) do
    Logger.error(reason)

    conn
    |> send_resp(400, reason)
  end
end
