defmodule AOC.Submarine.Command do
  defstruct [:direction, :magnitude]
end

defmodule AOC.Submarine.Orientation do
  defstruct horizontal: 0, depth: 0, aim: 0
end

defmodule AOC.Y2021.D2 do
  alias AOC.Submarine.Orientation

  def solve_part_1() do
    alias AOC.Y2021.D2.P1.Submarine.Navigation, as: Navigation

    parse_input()
    |> Navigation.process_orientations()
    |> (fn
          %Orientation{horizontal: horizontal, depth: depth} ->
            horizontal * depth
        end).()
  end

  def solve_part_2() do
    alias AOC.Y2021.D2.P2.Submarine.Navigation, as: Navigation

    parse_input()
    |> Navigation.process_orientations()
    |> (fn
          %Orientation{horizontal: horizontal, depth: depth} ->
            horizontal * depth
        end).()
  end

  def parse_input() do
    File.stream!("./lib/Y2021/D2/input.txt")
    |> Stream.map(&String.trim(&1))
    |> Stream.map(&String.split/1)
  end

  defmodule P1.Submarine.Navigation do
    @spec process_orientations(any) :: any
    def process_orientations(enum) do
      enum
      |> Stream.map(fn
        [direction, magnitude | _] ->
          %AOC.Submarine.Command{
            direction: String.to_atom(direction),
            magnitude: String.to_integer(magnitude)
          }
      end)
      |> Enum.reduce(%AOC.Submarine.Orientation{}, fn command, acc ->
        process_orientation(command, acc)
      end)
    end

    defp process_orientation(
           %AOC.Submarine.Command{direction: :forward, magnitude: magnitude},
           %AOC.Submarine.Orientation{horizontal: cur_hor, depth: cur_dep}
         ) do
      %AOC.Submarine.Orientation{horizontal: cur_hor + magnitude, depth: cur_dep}
    end

    defp process_orientation(
           %AOC.Submarine.Command{direction: :up, magnitude: magnitude},
           %AOC.Submarine.Orientation{horizontal: cur_hor, depth: cur_dep}
         ) do
      %AOC.Submarine.Orientation{horizontal: cur_hor, depth: cur_dep - magnitude}
    end

    defp process_orientation(
           %AOC.Submarine.Command{direction: :down, magnitude: magnitude},
           %AOC.Submarine.Orientation{horizontal: cur_hor, depth: cur_dep}
         ) do
      %AOC.Submarine.Orientation{horizontal: cur_hor, depth: cur_dep + magnitude}
    end
  end

  defmodule P2.Submarine.Navigation do
    def process_orientations(enum) do
      enum
      |> Stream.map(fn
        [direction, magnitude | _] ->
          %AOC.Submarine.Command{
            direction: String.to_atom(direction),
            magnitude: String.to_integer(magnitude)
          }
      end)
      |> Enum.reduce(%AOC.Submarine.Orientation{}, fn command, acc ->
        process_orientation(command, acc)
      end)
    end

    defp process_orientation(
           %AOC.Submarine.Command{direction: :forward, magnitude: magnitude},
           %AOC.Submarine.Orientation{horizontal: cur_hor, depth: cur_dep, aim: cur_aim}
         ) do
      %AOC.Submarine.Orientation{
        horizontal: cur_hor + magnitude,
        depth: cur_dep + cur_aim * magnitude,
        aim: cur_aim
      }
    end

    defp process_orientation(
           %AOC.Submarine.Command{direction: :up, magnitude: magnitude},
           %AOC.Submarine.Orientation{horizontal: cur_hor, depth: cur_dep, aim: cur_aim}
         ) do
      %AOC.Submarine.Orientation{horizontal: cur_hor, depth: cur_dep, aim: cur_aim - magnitude}
    end

    defp process_orientation(
           %AOC.Submarine.Command{direction: :down, magnitude: magnitude},
           %AOC.Submarine.Orientation{horizontal: cur_hor, depth: cur_dep, aim: cur_aim}
         ) do
      %AOC.Submarine.Orientation{horizontal: cur_hor, depth: cur_dep, aim: cur_aim + magnitude}
    end
  end
end
