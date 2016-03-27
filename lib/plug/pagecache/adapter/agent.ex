defmodule Plug.PageCache.Adapter.Agent do
  @moduledoc """
  PageCache adapter for agent style storage.
  """

  use Plug.PageCache.Adapter


  # Adapter lifecycle

  def init(opts) do
    { :ok, %{ auto_expire: opts[:auto_expire] || 0,
              entries:     %{} }}
  end


  # Adapter methods

  def clean(state) do
    { %{ state | entries: %{} }, :ok }
  end

  def load(state, path) do
    { state, load_unexpired(path, state) }
  end

  def remove(state, path) do
    { %{ state | entries: Map.delete(state.entries, path) }, :ok }
  end

  def save(state, path, page) do
    entry = { page, :os.system_time(:seconds) + state.auto_expire }

    { %{ state | entries: Map.put(state.entries, path, entry) }, :ok }
  end


  # Internal methods

  defp load_unexpired(path, %{ auto_expire: 0 } = state) do
    { page, _ } = Map.get(state.entries, path, { nil, 0 })
    page
  end

  defp load_unexpired(path, state) do
    { page, expire_after } = Map.get(state.entries, path, { nil, 0 })

    case :os.system_time(:seconds) <= expire_after do
      true  -> page
      false -> nil
    end
  end
end
