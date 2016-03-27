defmodule Plug.PageCache.Adapter.ETS do
  @moduledoc """
  PageCache adapter for ETS storage.
  """

  use Plug.PageCache.Adapter

  require Logger


  # Adapter lifecycle

  def init(opts) do
    ets_tid = case opts[:table] do
      nil ->
        Logger.warn "No ETS table configured for cache '#{ opts[:name] }'." <>
                    " Cache will be noop!"
        nil

      table -> :ets.new(table, [ :protected, :named_table, :set ])
    end

    { :ok, %{ auto_expire: opts[:auto_expire] || 0,
              ets_tid:     ets_tid }}
  end


  # Adapter methods

  def clean(state) do
    _ = :ets.delete_all_objects(state.ets_tid)

    { state, :ok }
  end

  def load(state, path) do
    case :ets.lookup(state.ets_tid, path) do
      [{ ^path, page, expire_after }] ->
        case :os.system_time(:seconds) <= expire_after do
          true  -> { state, page }
          false -> { state, nil }
        end

      _ -> { state, nil }
    end
  end

  def remove(state, path) do
    _ = :ets.delete(state.ets_tid, path)

    { state, :ok }
  end

  def save(state, path, page) do
    expire_after = :os.system_time(:seconds) + state.auto_expire
    _            = :ets.insert(state.ets_tid, { path, page, expire_after })

    { state, :ok }
  end
end
