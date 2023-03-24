# https://leetcode.com/problems/number-of-zero-filled-subarrays/

defmodule Solution do
  @spec zero_filled_subarray(nums :: [integer]) :: integer
  def zero_filled_subarray(nums) do
    count_zero_seqs_len(nums)
    |> Enum.map(&arithmetic_progression_sum/1)
    |> Enum.sum
  end

  defp count_zero_seqs_len(nums, len \\ 0, acc \\ [])
  defp count_zero_seqs_len([], 0, acc), do: acc
  defp count_zero_seqs_len([], len, acc), do: [len | acc]
  defp count_zero_seqs_len([0 | rest], len, acc), do: count_zero_seqs_len(rest, len + 1, acc)
  defp count_zero_seqs_len([_ | rest], 0, acc), do: count_zero_seqs_len(rest, 0, acc)
  defp count_zero_seqs_len([_ | rest], len, acc), do: count_zero_seqs_len(rest, 0, [len | acc])

  defp arithmetic_progression_sum(n), do: div((1 + n) * n, 2)
end

6 = Solution.zero_filled_subarray([1,3,0,0,2,0,0,4])
9 = Solution.zero_filled_subarray([0,0,0,2,0,0])
0 = Solution.zero_filled_subarray([2,10,2019])
