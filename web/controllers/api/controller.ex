defmodule ElixirHelper.Api.Controller do
  @moduledoc """
  """
  import Plug.Conn
  require Logger

  alias ElixirHelper.Api.Logic
  alias ElixirHelper.Api.Ets

  @spec run(Plug.Conn.t(), any) :: Plug.Conn.t()
  def run(conn, _params \\ []) do

    Enum.each(
      Ets.lookup_all, fn x -> IO.inspect x end
    )

    conn
    |> Logic.run()
    |> response(conn)
  end

  @spec response(Tuple, Plug.Conn.t()) :: Plug.Conn.t()
  def response({:ok, data}, conn) do
    Logger.info("Return results!")

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, data)
  end
  def response({:error, reason}, conn) do
    Logger.error("Error #{inspect reason}")

    conn
    |> send_resp(400, reason)
  end
end
