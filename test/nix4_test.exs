defmodule Nix4Test do
  use ExUnit.Case
  doctest Nix4

  test "greets the world" do
    assert Nix4.hello() == :world
  end
end
