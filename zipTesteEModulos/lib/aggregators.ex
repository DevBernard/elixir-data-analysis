defmodule Aggregators do
  def avg(list) do
    Enum.sum(list) / length(list)
  end

  def median(list) do
    n = length(list)
    case rem(n,2) do
      1 ->
        Enum.at(list, div(n,2))
      _ ->
        x = Enum.at(list, div(n,2) - 1)
        y = Enum.at(list, div(n,2))
       (x+y)/2
    end
  end

  def std_deviation(list) do
    avg = avg(list)
    n = length(list)
    aux = list
    |> Enum.map(& (&1 - avg)**2)
    |> Enum.sum

    (aux/n)**0.5
  end

end
