defmodule XmlDeserializerTest do
  use ExUnit.Case
  doctest Conditions

  alias Conditions.XmlDeserializer, as: XD

  def simple_test_data do
    [{:xmlElement,:current_observation,:current_observation, 
      [], {}, [], 2, [], 
      [
        {:xmlElement,:credit,:credit,[],{:xmlNamespace},[current_observation: 2],
          2, [], 
          [{:xmlText,[credit: 2, current_observation: 2], 1, [],
            'NOAA\'s National Weather Service',:text}
          ],[],'',:undeclared
        },
        {:xmlElement, :credit_URL,
          :credit_URL, [], {}, [current_observation: 2], 4, [],
          [{:xmlText, [credit_URL: 4, current_observation: 2], 1, [],
          'http://weather.gov/', :text}], [], '', :undeclared
        },
        {:xmlElement,:fake,:fake,[],{:xmlNamespace},[current_observation: 2],
          2, [], 
          [{:xmlText,[fake: 2, current_observation: 2], 1, [],
            'Yeah I made this one up.',:text}
          ],[],'',:undeclared
        },
      ], [], '',:undeclared
    }]
  end

  def tailless_test_data do
    [{:xmlElement,:current_observation,:current_observation, 
      [], {}, [], 2, [], 
      [
        {:xmlElement,:fake,:fake,[],{:xmlNamespace},[current_observation: 2],
          2, [], 
          [{:xmlText,[fake: 2, current_observation: 2], 1, [],
            'Yeah I made this one up.',:text}
          ],[],'',:undeclared
        },
      ], [], '',:undeclared
    }]
  end

  test "single level xml can be serialized" do
    result = XD.go(tailless_test_data)
    assert result == [current_observation: [fake: [_text: 'Yeah I made this one up.']]]
  end

  test "xml can be serialized" do
    result = XD.go(simple_test_data)
    assert result == [current_observation: 
      [ credit: [_text: 'NOAA\'s National Weather Service'], 
        credit_URL: [_text: 'http://weather.gov/'], 
        fake: [_text: 'Yeah I made this one up.'] ] ]
  end

  
end