# https://leetcode.com/problems/binary-watch/description/

Mix.install([
  :benchee
])

defmodule Solution do
  @hours_by_leds Enum.group_by(0..11, fn n -> Integer.digits(n, 2) |> Enum.count(&(&1 == 1)) end)

  @minutes_by_leds Enum.group_by(0..59, fn n -> Integer.digits(n, 2) |> Enum.count(&(&1 == 1)) end)

  @bits_in_num Map.new(0..59, fn n -> {n, Integer.digits(n, 2) |> Enum.count(&(&1 == 1))} end)

  @spec read_binary_watch(turned_on :: integer) :: [String.t()]
  def read_binary_watch(turned_on) do
    get_all_combinations(0, turned_on)
    |> Enum.map(fn {h, m} ->
      "#{h}:" <>
        (Integer.to_string(m) |> String.pad_leading(2, "0"))
    end)
  end

  @spec read_binary_watch2(turned_on :: integer) :: [String.t()]
  def read_binary_watch2(turned_on) do
    for h <- 0..11,
        m <- 0..59,
        @bits_in_num[h] + @bits_in_num[m] == turned_on,
        do:
          "#{h}:" <>
            (Integer.to_string(m) |> String.pad_leading(2, "0"))
  end

  defp get_all_combinations(hour_leds_qty, _) when hour_leds_qty > 4, do: []
  defp get_all_combinations(_, minutes_leds_qty) when minutes_leds_qty < 0, do: []

  defp get_all_combinations(hour_leds_qty, minutes_leds_qty) do
    hours = Map.get(@hours_by_leds, hour_leds_qty, [])
    minutes = Map.get(@minutes_by_leds, minutes_leds_qty, [])

    for(h <- hours, m <- minutes, do: {h, m}) ++
      get_all_combinations(hour_leds_qty + 1, minutes_leds_qty - 1)
  end
end

IO.inspect(Solution.read_binary_watch(1))
IO.inspect(Solution.read_binary_watch2(1))

["0:01", "0:02", "0:04", "0:08", "0:16", "0:32", "1:00", "2:00", "4:00", "8:00"] =
  Solution.read_binary_watch(1)

[] = Solution.read_binary_watch(9)

bench_variants = for _ <- 1..20_000, do: Enum.random(0..8)

Benchee.run(
  %{
    "less variants" => fn -> Enum.map(bench_variants, &Solution.read_binary_watch/1) end,
    "full brute" => fn -> Enum.map(bench_variants, &Solution.read_binary_watch/1) end
  },
  time: 10,
  memory_time: 2
)
