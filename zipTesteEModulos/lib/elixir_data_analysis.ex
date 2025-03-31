defmodule ElixirDataAnalysis do
  defp get_json_content(filename \\ "users-data.json") do
    filename
    |> File.read!
    |> Jason.decode!
  end


  defp get_json_metric_list(content, metric) when metric == "created_at" do
    now = DateTime.utc_now()
    content
    |> Enum.map(&DateTime.diff(elem(DateTime.from_iso8601(&1[metric]),1), now) * -1)
  end
  defp get_json_metric_list(content, metric) do
    content
    |> Enum.map(& &1[metric])
  end

  defp apply_analysis(list, metric) do
    {min, max} = Enum.min_max(list)
    %{
      :metric => metric,
      :min => min,
      :max => max,
      :avg => Aggregators.avg(list),
      :median => Aggregators.median(list),
      :std => Aggregators.std_deviation(list),
    }
  end

  defp print_analysis(map) do
    IO.puts("#{map.metric},#{map.min},#{map.max},#{map.avg},#{map.median},#{map.std}")
  end

  def print_analysis() do
    IO.puts("metric,min,max,avg,median,std")
  end

  def generate_analysis(metric) do
    content = get_json_content()
    list = get_json_metric_list(content, metric)
    applied = apply_analysis(list, metric)
    print_analysis(applied)
  end

  def generate_bonus_analysis() do
    # nao consegui realizar testes, pois imprime muito, e eu não estou familizarizado com Elixir
    IO.puts("location,count")
    get_json_content()
    |> Enum.group_by(& String.downcase(&1["location"] || "nao_informado"), fn _ -> 1 end)
    |> Enum.each(fn {loc, list} -> IO.puts("#{loc},#{length(list)}") end)
  end
end

metrics = ["followers_count","following_count","created_at"]
ElixirDataAnalysis.print_analysis()
metrics
|> Enum.each(&ElixirDataAnalysis.generate_analysis/1)

ElixirDataAnalysis.generate_bonus_analysis()
