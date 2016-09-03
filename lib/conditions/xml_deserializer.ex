defmodule Conditions.XmlDeserializer do

  @doc """
  Return a keyword list version of an (xml) list of tuples

  ## Examples

      iex> xml_list = [{:xmlElement, :current_observation, :current_observation, [], {}, [], 2, [],
        [{:xmlElement, :credit, :credit, [], {:xmlNamespace},
          [current_observation: 2], 2, [],
          [{:xmlText, [credit: 2, current_observation: 2], 1, [],
            'NOAA\'s National Weather Service', :text}], [], [], :undeclared},
         {:xmlElement, :credit_URL, :credit_URL, [], {}, [current_observation: 2], 4,
          [],
          [{:xmlText, [credit_URL: 4, current_observation: 2], 1, [],
            'http://weather.gov/', :text}], [], [], :undeclared},
        ], [], [], :undeclared}]

      iex> Conditions.XmlDeserializer.go(xml_list)
  """
  def go(xml) do
    List.flatten(xml)
    |> parse_xml
  end

  defp parse_xml({:xmlElement, key, _key2, _, _, _, _, _children, children2, _, _, _}) when key != nil do
    { key, parse_xml(children2) }
  end

  defp parse_xml({:xmlElement, key, _key2, _, _, _, _, children, _, _}) when key != nil do
    { key, parse_xml List.first(children) }
  end

  defp parse_xml({:xmlAttribute, key, _, _, _, _, _, [], value, _}) when key != nil do
    { key, value }
  end

  defp parse_xml({:xmlText, _, _, _, text, :text}) do
    { :_text, text }
  end

  defp parse_xml([]) do
  end

  defp parse_xml([head | []]) when head != nil do
    [parse_xml(head)]
  end

  defp parse_xml([head | nil]) when head != nil do
    [parse_xml(head)]
  end

  defp parse_xml([head | tail]) when tail != nil do
    [parse_xml(head) | parse_xml(tail)]
  end

  defp parse_xml(_) do
  end
end