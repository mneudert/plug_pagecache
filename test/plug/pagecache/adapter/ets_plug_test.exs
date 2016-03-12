defmodule Plug.PageCache.Adapter.ETSPlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Plug.PageCache.Config

  defmodule Router do
    use Plug.Router

    plug Plug.PageCache, cache: :ets

    plug :match
    plug :dispatch

    get "/test/adapter/ets_plug", do: send_resp(conn, 200, "OK")
  end

  test "plugging" do
    cache = Config.cache_id(:ets)
    path  = "/test/adapter/ets_plug"

    assert "OK" == conn(:get, path) |> Router.call([]) |> Map.get(:resp_body)
    assert "OK" == GenServer.call(cache, { :load, path })

    :ok = GenServer.call(cache, { :save, path, "CACHED" })

    assert "CACHED" == conn(:get, path) |> Router.call([]) |> Map.get(:resp_body)

    :ok = GenServer.call(cache, { :remove, path })

    assert "OK" == conn(:get, path) |> Router.call([]) |> Map.get(:resp_body)
  end
end
