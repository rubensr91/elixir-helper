defmodule ElixirHelper.CockroachController do
  @moduledoc """
  This controller contains an example of how to make a select query to a cockroach database
  """
  import Plug.Conn

  def init(_) do
    {:ok, nil}
  end

  @spec select(%Plug.Conn{}) :: %Plug.Conn{}

  def select(conn) do

    {:ok, pid} = Postgrex.start_link(hostname: "localhost",
      port: 26257, username: "roach", password: "1234", database: "bank", ssl: true)

    res = Postgrex.query!(pid, "select * from bank.accounts", [])
    IO.inspect res.rows

    conn
    |> put_resp_header("content-type", "text/plain")
    |> send_resp(200, "res")
  end
end
