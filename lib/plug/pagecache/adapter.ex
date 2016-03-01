defmodule Plug.PageCache.Adapter do
  @moduledoc """
  Cache adapter base server.

  One incarnation of it will be started for every properly configured cache.
  """

  defmacro __using__(_opts) do
    quote do
      use GenServer

      @behaviour unquote(__MODULE__)

      @doc """
      Starts the cache adapter.

      It will be registered under the id generated from its name
      by `Plug.PageCache.Config.cache_id/1`.
      """
      @spec start_link(Keyword.t) :: GenServer.on_start
      def start_link(opts) do
        GenServer.start_link(__MODULE__, opts, name: opts[:id])
      end

      def handle_call({ :load, path }, _from, state) do
        { state, res } = load(state, path)

        { :reply, res, state }
      end

      def handle_call({ :save, path, page }, _from, state) do
        { state, res } = save(state, path, page)

        { :reply, res, state }
      end
    end
  end


  @doc """
  Tries to load a page from the cache by its full path.
  """
  @callback load(state :: Keyword.t, path :: String.t) :: String.t | nil

  @doc """
  Saves a page to the cache.
  """
  @callback save(state :: Keyword.t, path :: String.t, page :: String.t) :: :ok
end
