defmodule Plug.PageCache.ConfigTest do
  use ExUnit.Case, async: true

  alias Plug.PageCache.Config

  test "get all caches" do
    caches = Config.caches

    assert nil != caches[:foo]
    assert nil != caches[:bar]
  end
end
