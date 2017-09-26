defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> cleanup()
    |> Enum.reduce(%{}, fn(word, acc) ->
      {_, acc} = Map.get_and_update(acc, word, fn(count) ->
        {count, (count || 0) + 1}
      end)
      acc
    end)
  end

  defp cleanup(sentence) do
    sentence
    |> String.replace(~r/(*UTF8)[^\w\s-]/, "")
    |> String.replace(~r/[_]/, " ")
    |> String.downcase()
    |> String.split()
  end
end
