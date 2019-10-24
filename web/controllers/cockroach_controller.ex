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

      Postgrex.query(pid, conn.query_params["sentence"], [])
      |> return_code(conn)
  end

  def return_code({:ok, %Postgrex.Result{command: :select} = result}, conn) do
    conn
    |> put_resp_header("content-type", "text/plain")
    |> send_resp(200,
      "Columns => #{inspect result.columns}\nValues => #{inspect result.rows}\nRows => #{inspect result.num_rows}")
  end

  def return_code({:ok, %Postgrex.Result{command: :insert} = result}, conn) do
    conn
    |> put_resp_header("content-type", "text/plain")
    |> send_resp(200, "You've inserted #{inspect result.num_rows} rows")
  end

  def return_code({:ok, %Postgrex.Result{command: :delete} = result}, conn) do
    conn
    |> put_resp_header("content-type", "text/plain")
    |> send_resp(200, "You've deleted #{inspect result.num_rows} rows")
  end

  def return_code({:ok, %Postgrex.Result{command: :update} = result}, conn) do
    conn
    |> put_resp_header("content-type", "text/plain")
    |> send_resp(200, "You've updated #{inspect result.num_rows} rows")
  end

  def return_code({:ok, %Postgrex.Result{} = result}, conn) do
    conn
    |> put_resp_header("content-type", "text/plain")
    |> send_resp(200, "#{inspect result}")
  end

  def return_code({:error, %Postgrex.Error{} = error}, conn) do
    conn
    |> put_resp_header("content-type", "text/plain")
    |> send_resp(400, error.postgres.message)
  end

end
