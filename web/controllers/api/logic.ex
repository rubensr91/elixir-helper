defmodule ElixirHelper.Api.Logic do
  @moduledoc """
  """

  require Logger
  alias NimbleCSV.RFC4180, as: CSV

  @data "~/elixir-helper/data.csv" |> File.read! |> CSV.parse_string()
         |> Enum.map(fn [_coma, div, season, date, hometeam, awayteam, fthg, ftag, ftr, hthg, htag, htr] ->
          %{"div" => div, "season" => season, "date" => date, "hometeam" => hometeam, "awayteam" => awayteam, 
          "fthg" => fthg, "ftag" => ftag, "ftr" => ftr, "hthg" => hthg, "htag" => htag, "htr" => htr}
         end)

  def run(conn) do
    Logger.info("Running application")
    
    filter_or_not_by_season(@data, conn.query_params["season"])
    |> filter_or_not_by_div(conn.query_params["div"])
    |> encode_file()
  end

  def filter_or_not_by_season({:error, _reason} = error, _params), do: error
  def filter_or_not_by_season(file, season_param)
       when is_binary(season_param) and byte_size(season_param) > 0 do
    Logger.info("Filtering by season => #{inspect season_param}")

    {:ok, Enum.filter(file, fn x -> x["season"] == season_param end)}
  end
  def filter_or_not_by_season(file, _params) do 
    Logger.info("No season filter found")

    {:ok, file}
  end

  def filter_or_not_by_div({:error, _reason} = error, _params), do: error
  def filter_or_not_by_div({:ok, file}, div_param)
       when is_binary(div_param) and byte_size(div_param) > 0 do
    Logger.info("Filtering by division => #{inspect div_param}")

    {:ok, Enum.filter(file, fn x -> x["div"] == div_param end)}
  end
  def filter_or_not_by_div({:ok, file}, _params) do 
    Logger.info("No division filter found")

    {:ok, file}    
  end

  def encode_file({:ok, file}) do
    Logger.info("Encondig #{Enum.count(file)} results")

    {:ok,
     file
     |> Jason.encode!()}
  end
  def encode_file({:error, _reason} = error) do
    Logger.error("Error encoding file #{inspect error}")

    error
  end
end
