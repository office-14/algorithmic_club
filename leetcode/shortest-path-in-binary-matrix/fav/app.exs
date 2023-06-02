# https://leetcode.com/problems/shortest-path-in-binary-matrix/

defmodule Solution do
  defmodule GridMap do
    defstruct [:map, :size, :right_bottom_pos]
  end

  @spec shortest_path_binary_matrix(grid :: [[integer]]) :: integer
  def shortest_path_binary_matrix(grid) do
    grid_as_map =
      Enum.with_index(grid)
      |> Enum.flat_map(fn {row, row_num} ->
        Enum.with_index(row)
        |> Enum.map(fn {value, col_num} -> {{row_num + 1, col_num + 1}, value} end)
      end)
      |> Map.new()

    size = length(grid)

    grid_map = %GridMap{
      map: grid_as_map,
      size: size,
      right_bottom_pos: {size, size}
    }

    find_shortest_path_length([{{0, 0}, 0}], grid_map, MapSet.new())
  end

  defp find_shortest_path_length([], _, _), do: -1

  defp find_shortest_path_length([{cur_pos, cur_len} | rest], grid_map, visited) do
    cond do
      cur_pos == grid_map.right_bottom_pos ->
        cur_len

      MapSet.member?(visited, cur_pos) ->
        find_shortest_path_length(rest, grid_map, visited)

      true ->
        valid_next_positions = get_neighbour_positions(cur_pos)
        |> Enum.filter(& is_valid_neighbour(&1, grid_map))
        |> Enum.map(& {&1, cur_len + 1})

        find_shortest_path_length(rest ++ valid_next_positions, grid_map, MapSet.put(visited, cur_pos))
    end
  end

  defp get_neighbour_positions({r, c}) do
    [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 0}, {0, 1}, {1, -1}, {1, 0}, {1, 1}]
    |> Enum.map(fn {dr, dc} ->
      {r + dr, c + dc}
    end)
  end

  defp is_valid_neighbour(pos, grid_map) do
    cond do
      Map.get(grid_map.map, pos) == 0 -> true
      true -> false
    end
  end
end

2 = Solution.shortest_path_binary_matrix([[0, 1], [1, 0]])
4 = Solution.shortest_path_binary_matrix([[0, 0, 0], [1, 1, 0], [1, 1, 0]])
-1 = Solution.shortest_path_binary_matrix([[1, 0, 0], [1, 1, 0], [1, 1, 0]])
