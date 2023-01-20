defmodule Solution do
  @spec find_subsequences(nums :: [integer]) :: [[integer]]
  def find_subsequences(nums) do
    2..length(nums)//1
    |> Enum.flat_map(fn subsize -> combinations(nums, subsize) end)
    |> Enum.filter(&check/1)
    |> Enum.uniq()
  end

  def check([_x]), do: true
  def check([head | tail]) do
    if head <= hd(tail), do: check(tail),
    else: false
  end

  def combinations(_list, 0), do: [[]]
  def combinations([], _num), do: []

  def combinations([head | tail], num) do
    Enum.map(combinations(tail, num - 1), &[head | &1]) ++
      combinations(tail, num)
  end
end

[4, 6, 7, 7] |> IO.inspect() |> then(&IO.inspect(Solution.find_subsequences(&1)))
# [4, 4, 3, 2, 1] |> IO.inspect() |> then(&IO.inspect(Solution.find_subsequences(&1)))
# [1,2,3,4,5,6,7,8,9,10,1,1,1,1,1] |> IO.inspect() |> then(&IO.inspect(Solution.find_subsequences(&1)))
