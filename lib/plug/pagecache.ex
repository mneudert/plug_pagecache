defmodule Plug.PageCache do
  @moduledoc """
  PageCache Plug
  """

  import Plug.Conn

  alias Plug.PageCache.Config

  @behaviour Plug

  def init(opts), do: opts |> Enum.into(%{})

  def call(conn, opts) do
    cache = Config.cache_id(opts[:cache])

    case GenServer.call(cache, {:load, conn.request_path}) do
      nil -> conn |> register_before_send(&save(&1, cache))
      page -> conn |> send_resp(200, page) |> halt()
    end
  end

  @doc """
  Saves a page to the cache.
  """
  @spec save(Plug.Conn.t(), atom) :: Plug.Conn.t()
  def save(conn, cache) do
    _ = GenServer.call(cache, {:save, conn.request_path, conn.resp_body})

    conn
  end
end
