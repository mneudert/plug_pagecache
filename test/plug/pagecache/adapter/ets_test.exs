defmodule Plug.PageCache.Adapter.ETSTest do
  use ExUnit.Case, async: false

  import ExUnit.CaptureIO

  alias Plug.PageCache.Config
  alias Plug.PageCache.Adapter.ETS

  test "warning if configuration is faulty" do
    opts = [ name: :faulty_config ]
    log  = capture_io :user, fn ->
      ETS.start_link(opts)
    end

    assert String.contains?(log, to_string(opts[:name]))
  end

  test "save/load lifecycle" do
    cache = Config.cache_id(:ets)
    page  = "Hello, World!"
    path  = "/test/adapter/ets"

    assert nil  == GenServer.call(cache, { :load, path })
    assert :ok  == GenServer.call(cache, { :save, path, page })
    assert page == GenServer.call(cache, { :load, path })
  end
end
