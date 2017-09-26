defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise "zero is invalid"
  def nth(count), do: do_nth(count, 1)

  defp do_nth(0, val), do: val
  defp do_nth(count, val) do
    val2 = val + 1
    case is_prime?(val2) do
      true ->
        count2 = count - 1
        do_nth(count2, val2)
      false ->
        do_nth(count, val2)
    end
  end

  defp is_prime?(2), do: true
  defp is_prime?(num) do
    Enum.all?(2..middle_point(num), &(divide_able?(&1, num)))
  end

  defp divide_able?(divisor, num) do
    rem(num, divisor) != 0
  end

  defp middle_point(num) do
    num / 2
    |> Float.ceil
    |> round
  end

end
