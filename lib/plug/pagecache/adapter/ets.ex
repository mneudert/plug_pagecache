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
end
