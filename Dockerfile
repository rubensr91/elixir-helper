FROM elixir:1.9
 
ENV PROJECT_ROOT=/elixir_helper
WORKDIR $PROJECT_ROOT
 
COPY . .
 
RUN mix local.hex --force
 
RUN mix local.rebar --force
 
RUN mix deps.get
 
RUN mix compile
 
EXPOSE 4001
 
CMD ["iex", "-S", "mix"]