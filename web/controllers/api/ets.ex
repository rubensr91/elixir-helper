defmodule ElixirHelper.Api.Ets do
  @moduledoc """
  """

  require Logger
  alias NimbleCSV.RFC4180, as: CSV

  @ets_table :elixir_helper
  @file_name ~w(data.csv)

  def run do
    create_table()
    insert()
  end

  defp create_table() do
    if :ets.info(@ets_table) == :undefined do
      Logger.info("Table ets #{@ets_table} created")
      :ets.new(@ets_table, [:public, :named_table])
    end
  end

  defp insert() do
    @file_name |> File.read! |> CSV.parse_string()
         |> Enum.map(fn [_coma, div, season, date, hometeam, awayteam, fthg, ftag, ftr, hthg, htag, htr] ->
          put({%{"div" => div, "season" => season, "date" => date, "hometeam" => hometeam, "awayteam" => awayteam, 
          "fthg" => fthg, "ftag" => ftag, "ftr" => ftr, "hthg" => hthg, "htag" => htag, "htr" => htr}, season})
         end)
  end

  def lookup_all() do
    :ets.foldl(
      fn item, acc ->
        acc ++ [item]
      end,
      [],
      @ets_table
    )
  end  

  def put(value) do
    case :ets.insert(@ets_table, value) do
      true -> :ok
      _ -> {:error, "error inserting ets #{inspect @ets_table} #{inspect value}"}
    end    
  end

#   def search(param) do
      
#   end

end