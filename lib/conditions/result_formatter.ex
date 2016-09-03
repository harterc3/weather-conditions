defmodule Conditions.ResultFormatter do

  @moduledoc """
  Print out keyword list data in nice format
  """
  
  def format_keyword_list([]) do
  end

  @doc """
  Handle printing each key,value in keyword list
  """
  def format_keyword_list([{key, [_text: val]} | tail]) do
    IO.puts("#{key}: #{val}")
    format_keyword_list(tail)
  end

  @doc """
  Handle multilevel keyword list
  """
  def format_keyword_list([{key, embed} | tail]) do
    IO.puts("#{key}:")
    format_keyword_list(embed)
    format_keyword_list(tail)
  end

  @doc """
  Handle non-tuple head in list
  """
  def format_keyword_list([_ | tail]) do
    format_keyword_list(tail)
  end
end