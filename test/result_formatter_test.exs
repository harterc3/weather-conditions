defmodule ResultFormatterTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias Conditions.ResultFormatter, as: RF

  def simple_test_data do
    [ c1: [_text: '1st line'],
      c2: [_text: '2nd line'],
      c3: [_text: '3rd line'] ]
  end

  test "Output is correct" do
    result = capture_io fn ->
      RF.format_keyword_list(simple_test_data)
    end
    assert result == """
    c1: 1st line
    c2: 2nd line
    c3: 3rd line
    """
  end
end