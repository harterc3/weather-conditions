defmodule Conditions.CLI do
  
  import Conditions.ResultFormatter, only: [ format_keyword_list: 1 ]
  alias Conditions.XmlDeserializer, as: XD

  @moduledoc """
  Main control module
  """

  def main(_argv) do
    observation = Conditions.WeatherConditions.fetch
    |> Tuple.to_list
    |> XD.go
    format_keyword_list(observation[:current_observation])
  end
end