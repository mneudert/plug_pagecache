defmodule Plug.PageCache.Adapter.AgentPlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Plug.PageCache.Config

  defmodule Router do
    use Plug.Router

    plug Plug.PageCache, cache: :agent

    plug :match
    plug :dispatch

    get "/test/adapter/agent_plug", do: send_resp(conn, 200, "OK")
  end

  test "plugging" do
    cache = Config.cache_id(:agent)
    path  = "/test/adapter/agent_plug"

    assert "OK" == conn(:get, path) |> Router.call([]) |> Map.get(:resp_body)
    assert "OK" == GenServer.call(cache, { :load, path })

    :ok = GenServer.call(cache, { :save, path, "CACHED" })

    assert "CACHED" == conn(:get, path) |> Router.call([]) |> Map.get(:resp_body)

    :ok = GenServer.call(cache, { :remove, path })

    assert "OK" == conn(:get, path) |> Router.call([]) |> Map.get(:resp_body)
  end

  test "cleaning" do
    cache = Config.cache_id(:agent)

    :ok = GenServer.call(cache, { :save, "/bar", "bar" })
    :ok = GenServer.call(cache, { :save, "/foo", "foo" })

    assert "bar" == GenServer.call(cache, { :load, "/bar" })
    assert "foo" == GenServer.call(cache, { :load, "/foo" })

    :ok = GenServer.call(cache, :clean)

    assert nil == GenServer.call(cache, { :load, "/bar" })
    assert nil == GenServer.call(cache, { :load, "/foo" })
  end
end
