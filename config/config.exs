# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :logger, :console,
  format: "$date $time $metadata[$level] $message\n",
  metadata: [:request_id]

# 30 mins, in ms
config :elixir_helper, ets_cleanup_period: 30 * 60 * 1000

# ETS Tables to dump on shutdown
config :elixir_helper,
  ets_tables_persistance: [
    tables: %{
      elixir_helper: :set
    }
  ]

if Mix.env() == :dev do
  config :mix_test_watch,
    tasks: [
      "test --cover",
      "credo --strict"
    ]
end

import_config "#{Mix.env()}.exs"
