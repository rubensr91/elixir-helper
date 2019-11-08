defmodule ElixirHelper.App do
  import Ecto.Query
  alias ElixirHelper.{Accounts, Repo}

  def keyword_query do
    query =
      from a in Accounts,
          #  where: a.prcp > 0 or is_nil(w.prcp),
           select: a

    Repo.all(query)
  end

  def pipe_query do
    Accounts
    # |> where(city: "Kraków")
    # |> order_by(:temp_lo)
    # |> limit(10)
    |> Repo.all
    |> IO.inspect
  end
end
