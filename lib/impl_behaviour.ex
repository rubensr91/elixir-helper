defmodule JSONParser do
  @behaviour Parser

  @impl Parser
  def parse(str), do: {:ok, "some json " <> str} # ... parse JSON
  
  @impl Parser
  def extensions, do: ["json"]
end