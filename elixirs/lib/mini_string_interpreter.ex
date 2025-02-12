# + - Increment the memory cell. If it reaches 256, wrap to 0.
# . - Output the value of the memory cell as a character with code point equal to the value

defmodule Elixirs.MiniStringInterpreter do
  @moduledoc false

  def execute(command) do
    strings = command |> to_str_arr(~r{\.})

    reduce_commands(strings, 0, [])
  end

  def reduce_commands([_ | tail], codepoint, output) when tail == [] do
    "#{[codepoint | output] |> Enum.reverse}"
  end

  def reduce_commands([head | tail], codepoint, output) do
    if head == "." do
      reduce_commands(tail, codepoint, [codepoint | output])
    else
      reduce_commands(tail, to_codepoint(head, codepoint), output)
    end
  end

  def to_codepoint(str, codepoint) do
    strings = to_str_arr(str, ~r{\+})

    reduce_codepoint(strings, codepoint)
  end

  def reduce_codepoint([_ | tail], codepoint) when tail == [] do
    codepoint + 1
  end

  def reduce_codepoint([_ | tail], codepoint) do
    if codepoint + 1 >= 256 do
      reduce_codepoint(tail, 0)
    else
      reduce_codepoint(tail, codepoint + 1)
    end
  end

  def to_str_arr(str, delimiter) do
    String.split(str, delimiter, include_captures: true, trim: true)
  end
end
