# https://leetcode.com/problems/binary-watch/description/

defmodule Solution do
  @hours_by_leds Enum.group_by(0..11, fn n -> Integer.digits(n, 2) |> Enum.count(&(&1 == 1)) end)

  @minutes_by_leds Enum.group_by(0..59, fn n -> Integer.digits(n, 2) |> Enum.count(&(&1 == 1)) end)

  @spec read_binary_watch(turned_on :: integer) :: [String.t()]
  def read_binary_watch(turned_on) do
    get_all_combinations(0, turned_on)
    |> Enum.map(fn {h, m} ->
      Integer.to_string(h) <>
        ":" <>
        (Integer.to_string(m) |> String.pad_leading(2, "0"))
    end)
  end

  defp get_all_combinations(_, -1), do: []

  defp get_all_combinations(hour_leds_qty, minutes_leds_qty) do
    case {@hours_by_leds[hour_leds_qty], @minutes_by_leds[minutes_leds_qty]} do
      {nil, _} -> []
      {_, nil} -> []
      {hours, minutes} -> for h <- hours, m <- minutes, do: {h, m}
    end ++ get_all_combinations(hour_leds_qty + 1, minutes_leds_qty - 1)
  end
end

["0:01", "0:02", "0:04", "0:08", "0:16", "0:32", "1:00", "2:00", "4:00", "8:00"] =
  Solution.read_binary_watch(1)

[] = Solution.read_binary_watch(9)
