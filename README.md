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

## COCKROACH
    mkdir certs my-safe-directory
    cockroach cert create-ca --certs-dir=certs --ca-key=my-safe-directory/ca.key
    cockroach cert create-client root --certs-dir=certs --ca-key=my-safe-directory/ca.key
    cockroach cert create-node localhost $(hostname) --certs-dir=certs --ca-key=my-safe-directory/ca.key
    cockroach start --certs-dir=certs --listen-addr=localhost

    cockroach sql --certs-dir=certs --host=localhost:26257 # this is to get inside cockroachdb
    once inside, you have to create database, table... etc

    CREATE DATABASE BANK;
    CREATE TABLE BANK.ACCOUNTS (ID INT)

    cockroach --certs-dir=certs user set roach —password

    # to test everything you must to do:
    
    iex -S mix
    
    {:ok, pid} = Postgrex.start_link(hostname: "localhost",
      port: 26257, username: "roach", password: "1234", database: "bank", ssl: true)

    Postgrex.query!(pid, "select * from bank.accounts", [])
