defmodule ServiceEmailerTest do
  use ExUnit.Case
  doctest ServiceEmailer

  test "greets the world" do
    assert ServiceEmailer.hello() == :world
  end
end
