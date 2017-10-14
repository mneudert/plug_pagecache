defmodule Plug.PageCache.Config do
  @moduledoc """
  Handles access to cache (application) configuration.
  """

  @doc """
  Returns the internal id for a cache.
  """
  @spec cache_id(atom) :: atom
  def cache_id(name), do: :"plug_pagecache_#{name}"

  @doc """
  Returns all configured caches with their options.
  """
  @spec caches() :: Keyword.t()
  def caches, do: Application.get_env(:plug_pagecache, :caches, [])
end
