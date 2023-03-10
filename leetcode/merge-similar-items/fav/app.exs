# https://leetcode.com/problems/merge-similar-items/

defmodule Solution do
  @spec merge_similar_items(items1 :: [[integer]], items2 :: [[integer]]) :: [[integer]]
  def merge_similar_items(items1, items2) do
    (items1 ++ items2)
    |> Enum.reduce(%{}, fn [value, weight], res ->
      Map.get_and_update(res, value, fn
        nil -> {nil, weight}
        val -> {val, weight + val}
      end)
      |> elem(1)
    end)
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.sort()
  end
end

IO.inspect(Solution.merge_similar_items([[3,2],[1,1],[2,3]], [[3,2],[2,1],[1,3]]))
