# https://leetcode.com/problems/find-all-anagrams-in-a-string/

defmodule Solution do
  @spec find_anagrams(s :: String.t, p :: String.t) :: [integer]
  def find_anagrams(s, p) do
    freq_target = String.graphemes(p) |> Enum.frequencies()
    p_len = String.length(p)
    s_list = String.graphemes(s)

    first_part = s_list |> Enum.take(p_len)

    char_pairs = Enum.zip(s_list, Enum.drop(s_list, p_len))

    do_find_anagrams(char_pairs ++ [Enum.at(s_list, -1)], freq_target, Enum.frequencies(first_part), 0)
  end

  defp do_find_anagrams(char_pairs, freq_target, freqs, cur_index, acc \\ [])

  defp do_find_anagrams([], _, _, _, acc), do: Enum.reverse(acc)

  defp do_find_anagrams([_], freq_target, freqs, cur_index, acc) do
    new_acc = if freq_target == freqs do
      [cur_index | acc]
    else
      acc
    end

    do_find_anagrams([], freq_target, freqs, cur_index, new_acc)
  end

  defp do_find_anagrams([{prev, cur} | rest_ch_pairs], freq_target, freqs, cur_index, acc) do
    new_acc = if freq_target == freqs do
      [cur_index | acc]
    else
      acc
    end
    new_freqs = freqs
    |> Map.update!(prev, fn freq -> freq - 1 end)
    |> Map.reject(fn {_, val} -> val == 0 end)
    |> Map.update(cur, 1, fn freq -> freq + 1 end)

    do_find_anagrams(rest_ch_pairs, freq_target, new_freqs, cur_index + 1, new_acc)
  end
end

IO.inspect(Solution.find_anagrams("abcabcabc", "abc"))

[0,6] = Solution.find_anagrams("cbaebabacd", "abc")
[0,1,2] = Solution.find_anagrams("abab", "ab")
