defmodule Plug.PageCache.ConfigTest do
  use ExUnit.Case, async: true

  alias Plug.PageCache.Config

  test "cache startup" do
    Enum.each(Config.caches(), fn {name, _opts} ->
      pid = name |> Config.cache_id() |> Process.whereis()

      assert is_pid(pid)
    end)
  end
end
