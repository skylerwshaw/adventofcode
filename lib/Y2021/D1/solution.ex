defmodule AOC.Y2021.D1 do
  def solve_part_1() do
    parse_input()
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.count(fn [left, right] -> left < right end)
  end

  def solve_part_2() do
    parse_input()
    |> Stream.chunk_every(3, 1, :discard)
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.count(fn [[left, m1, m2], [m1, m2, right]] -> left < right end)
  end

  def parse_input() do
    File.stream!("./lib/Y2021/D1/input.txt")
    |> Stream.map(&String.trim(&1))
    |> Stream.map(&String.to_integer(&1))
  end
end
