defmodule PwProjectTest do
  use ExUnit.Case
  doctest PwProject

  test "greets the world" do
    assert PwProject.hello() == :world
  end
end
