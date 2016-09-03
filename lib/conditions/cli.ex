defmodule Conditions.CLI do
  def main(_argv) do
    observation = Conditions.WeatherConditions.fetch
    |> Tuple.to_list
    |> Conditions.XmlDeserializer.go
    Conditions.ResultFormatter.format_keyword_list(observation[:current_observation])
  end
end