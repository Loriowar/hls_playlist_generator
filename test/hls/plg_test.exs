defmodule HLS.PlgTest do
  use ExUnit.Case
  doctest HLS.Plg

  test "greets the world" do
    assert HLS.Plg.hello() == :world
  end
end
