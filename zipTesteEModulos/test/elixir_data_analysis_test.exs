defmodule ElixirDataAnalysisTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "verify something" do
    expected = "followers_count,0,11354,43.61150353178608,1,244.6035446670143\n"
    result = capture_io(fn -> ElixirDataAnalysis.generate_analysis("followers_count") end)
    assert result == expected
  end
end
