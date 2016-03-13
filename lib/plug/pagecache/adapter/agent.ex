defmodule Plug.PageCache.Adapter.Agent do
  @moduledoc """
  PageCache adapter for agent style storage.
  """

  use Plug.PageCache.Adapter

  def init(_opts), do: { :ok, %{} }

  def clean(_state),           do: { %{}, :ok }
  def load(state, path),       do: { state, Map.get(state, path, nil) }
  def remove(state, path),     do: { Map.delete(state, path), :ok }
  def save(state, path, page), do: { Map.put(state, path, page), :ok }
end
