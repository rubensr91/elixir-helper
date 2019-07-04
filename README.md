 # HOW TO
 * git clone https://github.com/rubensr91/elixir_helper.git
 * cd elixir_helper/
 * mix deps.get
 * mix compile
 * iex -S mix
 * To see if everything run ok, the next step must to return "pong" in the browser
 * http://localhost:4001/ping 
 * To see all games results
 * http://localhost:4001/api/laliga
 * To see filter results
 * http://localhost:4001/api/laliga?season=201617
 * To see metrics of the aplication 
 * http://localhost:4001/metrics
 * To see version github
 * http://localhost:4001/version
 * Run mix run --no-halt and next go to http://127.0.0.1:8080/ to see web machine working

## COVERALLS
 * mkdir -p priv/repo/migrations
 * MIX_ENV=test mix coveralls