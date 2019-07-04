defmodule ElixirHelper.ApiRouter do
  @moduledoc """
  Api router
  Just call to Controller
  """
  use Plug.Router

  alias ElixirHelper.Api.Controller, as: Controller

  plug(:match)
  plug(:dispatch)

  get("/laliga", do: Controller.run(conn))

  match _ do
    send_resp(conn, 404, "oops")
  end

end
