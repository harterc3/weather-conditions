defmodule Conditions.WeatherConditions do
  require Logger
  require Record
  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText,    Record.extract(:xmlText,    from_lib: "xmerl/include/xmerl.hrl")

  @weather_url Application.get_env(:conditions, :weather_url)
  def fetch do
    @weather_url
    |> HTTPoison.get
    |> handle_response
  end

  defp handle_response({ :ok, %{status_code: 200, body: body}}) do
    body
    |> String.replace(~r/[\n\r\t]/, "")
    |> String.replace(~r/\'\s*\'/, "")
    |> :binary.bin_to_list
    |> :xmerl_scan.string
  end

  defp handle_response({ __, %{status_code: _status, body: body}}) do
    {_, message} = body
    |> :binary.bin_to_list
    |> :xmerl_scan.string
    |> List.keyfind("message", 0)
    IO.puts "Error fetching from Github: #{message}"
    System.halt(2)
  end
  
end