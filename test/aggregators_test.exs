defmodule AggregatorsTest do
  use ExUnit.Case

  test "tests avg value" do
    x = [1,5,2,4,3]
    assert Aggregators.avg(x) == 3
  end

  test "tests median value" do
    x = [0,1,1,2,3,3,3,4,5]
    assert Aggregators.median(x) == 3
    x = [0,1,2,3]
    assert Aggregators.median(x) == 1.5
  end

  test "tests std value" do
    x = [0,0,0,0,0]
    assert Aggregators.std_deviation(x) == 0
    x = [0,1,2,3,4,5,6]
    assert Aggregators.std_deviation(x) == 2
  end
end
