defmodule Test do
  @moduledoc false
  use ExUnit.Case
  use Plug.Test

  alias ElixirHelper.Api.{Logic, Controller}

  test "testing laliga with bad params" do
    conn = conn(:get, "/api/laliga?bad&gdfgndljfkhng&f28f723fh/")
    conn = Controller.run(conn)

    assert conn.resp_body == Jason.encode!([])
  end

  test "testing laliga bad response" do
    conn = conn(:get, "/api/laliga")
    conn = Controller.response({:error, "error from test"}, conn)

    assert conn.resp_body == "error from test"
  end

  test "testing laliga filter_or_not_by_params" do
    conn = conn(:get, "/api/laliga")
    {:error, reason} = Logic.filter_or_not_by_params({:error, "error from test"}, "")

    assert reason == "error from test"
  end

  test "testing laliga encode_file" do
    conn = conn(:get, "/api/laliga")
    {:error, reason} = Logic.encode_file({:error, "error from test"})

    assert reason == "error from test"
  end
end
