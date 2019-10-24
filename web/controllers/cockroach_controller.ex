defmodule ElixirHelper.CockroachController do
  @moduledoc """
  This controller contains an example of how to make a select query to a cockroach database
  """
  import Plug.Conn

  def init(_) do
    {:ok, nil}
  end

  @spec sentence(%Plug.Conn{}) :: %Plug.Conn{}

  def sentence(conn) do
    {:ok, pid} = Postgrex.start_link(hostname: conn.query_params["hostname"],
      port: conn.query_params["port"], username: conn.query_params["user"],
      password: conn.query_params["password"],
      database: conn.query_params["db"], ssl: true)

    sentence =
      try do
        Postgrex.query!(pid, conn.query_params["sentence"], [])
      rescue
        e in Postgrex.Error -> IO.puts("#{inspect e}")
      end

    IO.inspect sentence

    conn
    |> put_resp_header("content-type", "text/plain")
    |> send_resp(200, "#{inspect sentence}")
  end

end
