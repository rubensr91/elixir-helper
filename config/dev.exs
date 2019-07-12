use Mix.Config

config :elixir_helper, port: 4001

config :logger, :console, format: "[$level] $message\n"

config :mix_test_watch,
tasks: [
    "test --cover",
    "credo --strict"
]