defmodule Conditions.ResultFormatter do
	def format_keyword_list([]) do
	end
	def format_keyword_list([{key, [_text: val]} | tail]) do
		IO.puts("#{key}: #{val}")
		format_keyword_list(tail)
	end
	def format_keyword_list([{key, embed} | tail]) do
		format_keyword_list(embed)
		format_keyword_list(tail)
	end
	def format_keyword_list([_ | tail]) do
		format_keyword_list(tail)
	end
end