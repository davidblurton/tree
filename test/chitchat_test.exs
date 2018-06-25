defmodule ChitchatTest do
  use ExUnit.Case
  doctest Chitchat

  test "greets the world" do
    assert Chitchat.hello() == :world
  end
end
