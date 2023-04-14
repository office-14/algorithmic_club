# https://leetcode.com/problems/reorder-routes-to-make-all-paths-lead-to-the-city-zero/

defmodule Solution do
  @spec min_reorder(n :: integer, connections :: [[integer]]) :: integer
  def min_reorder(_n, connections) do
    map_from =
      connections
      |> Enum.reduce(Map.new(), fn [from, to], acc ->
        {_, res} = Map.get_and_update(acc, from, fn v -> {v, List.wrap(v) ++ [to]} end)
        res
      end)

    map_to =
      connections
      |> Enum.reduce(Map.new(), fn [from, to], acc ->
        {_, res} = Map.get_and_update(acc, to, fn v -> {v, List.wrap(v) ++ [from]} end)
        res
      end)

    bfs([0], map_from, map_to, MapSet.new(), 0)
  end

  def bfs([], _, _, _, res), do: res

  def bfs([cur_city | rest], map_from, map_to, visited, res) do
    cond do
      MapSet.member?(visited, cur_city) ->
        bfs(rest, map_from, map_to, visited, res)

      true ->
        next_to_reverse = Map.get(map_from, cur_city, [])
         |> Enum.reject(fn x -> MapSet.member?(visited, x) end)
        next = Map.get(map_to, cur_city, [])

        bfs(
          rest ++ next ++ next_to_reverse,
          map_from,
          map_to,
          MapSet.put(visited, cur_city),
          res + length(next_to_reverse)
        )
    end
  end
end

3 = Solution.min_reorder(6, [[0, 1], [1, 3], [2, 3], [4, 0], [4, 5]])
2 = Solution.min_reorder(5, [[1, 0], [1, 2], [3, 2], [3, 4]])
0 = Solution.min_reorder(3, [[1, 0], [2, 0]])
