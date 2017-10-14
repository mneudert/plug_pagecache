defmodule Plug.PageCache.Adapter.ETSExpireTest do
  use ExUnit.Case, async: true

  alias Plug.PageCache.Config

  test "auto expire after 1 second" do
    cache = Config.cache_id(:ets_expire)
    path = "/"

    :ok = GenServer.call(cache, {:save, path, "CACHED"})
    "CACHED" = GenServer.call(cache, {:load, path})

    :timer.sleep(500)

    "CACHED" = GenServer.call(cache, {:load, path})

    :timer.sleep(1750)

    assert nil == GenServer.call(cache, {:load, path})
  end
end
