# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :logger, :console,
  format: "$date $time $metadata[$level] $message\n",
  metadata: [:request_id]

# # 30 mins, in ms
# config :elixir_helper, ets_cleanup_period: 30 * 60 * 1000

# # ETS Tables to dump on shutdown
# config :elixir_helper,
#   ets_tables_persistance: [
#     tables: %{
#       elixir_helper: :set
#     }
#   ]

config :elixir_helper, ElixirHelper.Repo, adapter: Ecto.Adapters.Postgres,
  username: "roach",
  password: "1234",
  database: "bank",
  hostname: "localhost",
  ssl: true,
  pool: 10,
  ssl_opts: [
    cacertfile: "certs/ca.crt",
    keyfile: "certs/node.key",
    certfile: "certs/node.crt"
  ]

import_config "#{Mix.env()}.exs"
