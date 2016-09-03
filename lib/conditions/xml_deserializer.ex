defmodule Conditions.XmlDeserializer do
  def go(xml) do
    List.flatten(xml)
    |> parse_xml
  end

  def parse_xml({:xmlElement, key, _key2, _, _, _, _, _children, children2, _, _, _}) when key != nil do
    { key, parse_xml(children2) }
  end

  def parse_xml({:xmlElement, key, _key2, _, _, _, _, children, _, _}) when key != nil do
    { key, parse_xml List.first(children) }
  end

  def parse_xml({:xmlAttribute, key, _, _, _, _, _, [], value, _}) when key != nil do
    { key, value }
  end

  def parse_xml({:xmlText, _, _, _, text, :text}) do
    { :_text, text }
  end

  def parse_xml([]) do
  end

  def parse_xml([head | []]) when head != nil do
    [parse_xml(head)]
  end

  def parse_xml([head | nil]) when head != nil do
    [parse_xml(head)]
  end

  def parse_xml([head | tail]) when tail != nil do
    [parse_xml(head) | parse_xml(tail)]
  end

  def parse_xml(_) do
  end
end