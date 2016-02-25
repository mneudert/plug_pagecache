defmodule Plug.PageCache.Adapter do
  @moduledoc """
  Cache adapter base server.

  One incarnation of it will be started for every properly configured cache.
  """

  defmacro __using__(_opts) do
    quote do
      use GenServer

      @doc """
      Starts the cache adapter.

      It will be registered under the id generated from its name
      by `Plug.PageCache.Config.cache_id/1`.
      """
      @spec start_link(Keyword.t) :: GenServer.on_start
      def start_link(opts) do
        GenServer.start_link(__MODULE__, opts, name: opts[:id])
      end
    end
  end
end
