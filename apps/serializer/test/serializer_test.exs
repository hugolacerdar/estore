defmodule SerializerTest do
  use ExUnit.Case
  doctest Serializer

  test "greets the world" do
    assert Serializer.hello() == :world
  end
end
