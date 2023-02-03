# https://leetcode.com/problems/count-items-matching-a-rule/

defmodule Solution do
  @spec count_matches(items :: [[String.t]], rule_key :: String.t, rule_value :: String.t) :: integer
  def count_matches(items, rule_key, rule_value) do
    Enum.count(items, fn [type, color, name] ->
      case rule_key do
        "type" -> type == rule_value
        "color" -> color == rule_value
        "name" -> name == rule_value
      end
    end)
  end
end
