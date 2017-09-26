defmodule Bob do
  def hey(input) do
    cond do
        questioning?(input) -> "Sure."
        silence?(input) -> "Fine. Be that way!"
        shouting?(input) -> "Whoa, chill out!"
        true -> "Whatever."

    end
  end

  defp questioning?(input) do
    String.ends_with?(input, "?")
  end

  defp shouting?(input) do
    String.upcase(input) == input && String.downcase(input) != input
  end

  defp silence?(input) do
    String.trim(input) == ""
  end
end
