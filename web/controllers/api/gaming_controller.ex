defmodule ElixirHelper.Gaming.Controller do
  @moduledoc """
  """
  import Plug.Conn
  require Logger

  @spec login(%Plug.Conn{}) :: %Plug.Conn{}
  @url "https://api.cdmolo.com:16800"

  def login(conn) do

    Logger.info "#{inspect conn.params}"

    res = HTTPoison.post @url <>
    "/v1/player/login?player_account=abc123&country=en&ip=192.168.0.11&AccessKeyId=8b7f2e35-7499-450f-ae5e-306c079013fd&Timestamp=1534993631&Nonce=2394347&Sign=78bcb04f05efc68efff1ca11fd594a9ffb8468c3",
    "{\"body\": \"test\"}",
    [{"Content-Type", "application/json"}]

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, "#{inspect res}")
  end

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
