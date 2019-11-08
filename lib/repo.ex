defmodule ElixirHelper.Repo do
  use Ecto.Repo,
    otp_app: :elixir_helper,
    adapter: Ecto.Adapters.Postgres
end
