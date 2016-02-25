defmodule Plug.PageCacheTest do
  use ExUnit.Case, async: true
  use Plug.Test

  defmodule Router do
    use Plug.Router

    plug Plug.PageCache

    plug :match
    plug :dispatch

    get "/", do: send_resp(conn, 200, "OK")
  end

  test "plugging" do
    conn = conn(:get, "/") |> Router.call([])

    assert "OK" == conn.resp_body
  end
end
