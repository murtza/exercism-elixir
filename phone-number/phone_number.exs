defmodule Phone do
  @bad_number "0000000000"

  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    case has_alpha?(raw) do
      true -> raw
              |> String.replace(~r/[\(\)\.\-\s\+]/, "")
              |> do_number
      _ ->  @bad_number
    end
  end

  defp do_number(<<area_code::binary-3>> <> <<num::binary-7>>) do
    cond  do
      invalid?(area_code) -> @bad_number
      invalid?(num) -> @bad_number
      true -> "#{area_code}#{num}"
    end
  end
  defp do_number("1" <> <<num::binary-10>>), do: num
  defp do_number(_invalid_num), do: @bad_number


  defp has_alpha?(raw) do
    case Regex.scan(~r/[a-zA-Z]/, raw) do
      [] -> true
      _ -> false
    end
  end

  defp invalid?(num) do
    String.starts_with?(num, ["0", "1"])
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    <<area_code::binary-3>> <> _num = number(raw)
    area_code
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    <<area_code::binary-3>> <> <<first::binary-3>> <> <<last::binary-4>>
      = number(raw)
    "(#{area_code}) #{first}-#{last}"
  end
end
