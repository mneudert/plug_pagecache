defmodule Plug.PageCache.Adapter.Agent do
  @moduledoc """
  PageCache adapter for agent style storage.
  """

  use Plug.PageCache.Adapter


  # Adapter lifecycle

  def init(_opts), do: { :ok, %{ entries: %{} } }


  # Adapter methods

  def clean(state) do
    { %{ state | entries: %{} }, :ok }
  end

  def load(state, path) do
    { state, Map.get(state.entries, path, nil) }
  end

  def remove(state, path) do
    { %{ state | entries: Map.delete(state.entries, path) }, :ok }
  end

  def save(state, path, page) do
    { %{ state | entries: Map.put(state.entries, path, page) }, :ok }
  end
end
