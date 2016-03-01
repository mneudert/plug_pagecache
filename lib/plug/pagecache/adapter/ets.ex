defmodule Plug.PageCache.Adapter.ETS do
  @moduledoc """
  PageCache adapter for ETS storage.
  """

  use Plug.PageCache.Adapter

  require Logger

  def init(opts) do
    ets_tid = case opts[:table] do
      nil ->
        Logger.warn "No ETS table configured for cache '#{ opts[:name] }'." <>
                    " Cache will be noop!"
        nil

      table -> :ets.new(table, [ :protected, :named_table, :set ])
    end

    { :ok, %{ ets_tid: ets_tid }}
  end


  def load(state, path) do
    case :ets.lookup(state.ets_tid, path) do
      [{ ^path, page }] -> { state, page }
      _                 -> { state, nil }
    end
  end

  def save(state, path, page) do
    _ = :ets.insert(state.ets_tid, { path, page })

    { state, :ok }
  end
end
