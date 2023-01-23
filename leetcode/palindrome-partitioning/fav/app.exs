# https://leetcode.com/problems/palindrome-partitioning/

defmodule Solution do
  @spec partition(s :: String.t) :: [[String.t]]
  def partition(s) do
    do_partition(s)
    |> Enum.filter(fn partitions -> Enum.all?(partitions, &is_palindrome?/1) end)
    |> Enum.reverse()
  end

  defp do_partition(str, acc \\ [])

  defp do_partition("", acc), do: [acc |> Enum.map(&String.reverse/1) |> Enum.reverse]

  defp do_partition(<<first::binary-size(1), rest::binary>>, acc) do
    case (acc) do
      [left | rest_acc] ->
        do_partition(rest, [first <> left | rest_acc]) ++
          do_partition(rest, [first, left | rest_acc])
      _ -> do_partition(rest, [first | acc])
    end
  end

  defp is_palindrome?(str) do
    str == String.reverse(str)
  end
end

[["a","a","b"],["aa","b"]] = Solution.partition("aab")
[["a"]] = Solution.partition("a")

