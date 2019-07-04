defmodule ElixirHelper.Api.Logic do
  @moduledoc """
  """

  require Logger
  alias NimbleCSV.RFC4180, as: CSV

  @data "data.csv" |> File.read! |> CSV.parse_string()
         |> Enum.map(fn [_coma,div,season,date,hometeam,awayteam,fthg,ftag,ftr,hthg,htag,htr] ->
          %{div: div,season: season,date: date,hometeam: hometeam,awayteam: awayteam,fthg: fthg,ftag: ftag,
             ftr: ftr,hthg: hthg,htag: htag,htr: htr}
         end)

  @spec run(binary() | []) :: {:error, <<_::144>>} | {:ok, binary()}

  def run(params \\ nil) do
    filter_or_not_by_params(@data, params)
    |> encode_file()
  end

  @spec filter_or_not_by_params({:error, <<_::144>>} | {:ok, [any()]}, <<_::144>>) ::
          {:error, <<_::144>>} | {:ok, [any()]}

  def filter_or_not_by_params({:error, _reason} = error, _params), do: error
  def filter_or_not_by_params(file, param)
       when is_binary(param) and byte_size(param) > 0 do
    {:ok, Enum.filter(file, &(&1.season == param))}
  end
  def filter_or_not_by_params(file, _params), do: {:ok, file}


  @spec encode_file({:error, <<_::144>>} | {:ok, [any()]}) ::
          {:error, <<_::144>>} | {:ok, binary()}

  def encode_file({:ok, file}) do
    {:ok,
     file
     |> Jason.encode!()}
  end
  def encode_file({:error, _reason} = error), do: error
end
