 # HOW TO
 * git clone https://github.com/rubensr91/elixir_helper.git
 * cd elixir_helper/
 * mix deps.get
 * mix compile
 * iex -S mix
 * To see if everything run ok, the next step must to return "pong" in the browser
 * http://localhost:4001/ping 

## COVERALLS
 * mkdir -p priv/repo/migrations
 * MIX_ENV=test mix coveralls
