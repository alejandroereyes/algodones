# + - Increment the memory cell. If it reaches 256, wrap to 0.
# . - Output the value of the memory cell as a character with code point equal to the value

defmodule Elixirs.MiniStringInterpreter do
  @moduledoc false

  def execute(command) do
    command
      |> String.replace(~r{[^\+\.]}, "")
      |> String.split(~r{.}, include_captures: true, trim: true)
      |> reduce_commands(0, [])
  end

  def reduce_commands([], _codepoint, output) do
    "#{output |> Enum.reverse}"
  end

  def reduce_commands(["." | tail], codepoint, output) do
    reduce_commands(tail, codepoint, [codepoint | output])
  end

  def reduce_commands(["+" | tail], codepoint, output) do
    if codepoint >= 255 do
      reduce_commands(tail, 0, output)
    else
      reduce_commands(tail, codepoint + 1, output)
    end
  end
end
