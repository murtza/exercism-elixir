defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    do_flatten(list, []) |> Enum.reverse
  end

  defp do_flatten([], acc), do: acc
  defp do_flatten([nil | tail], acc), do: do_flatten(tail, acc)
  defp do_flatten([head | tail], acc) when is_list(head) do
    acc2 = do_flatten(head, acc)
    do_flatten(tail, acc2)
  end
  defp do_flatten([head | tail], acc) do
    do_flatten(tail, [head | acc])
  end
  # defp do_flatten(_acc, []), do: []
  # defp do_flatten(acc, [nil | tail]), do: do_flatten(acc, tail)
  # defp do_flatten(acc, [head | tail]) when is_list(head) do
  #   acc2 = do_flatten(acc, head)
  #   do_flatten(acc2, tail)
  # end
  # defp do_flatten(acc, [head | tail]) do
  #   acc2 = [head | acc]
  #   do_flatten(acc2, tail)
  # end
  #


end
