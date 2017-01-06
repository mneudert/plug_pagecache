defmodule Plug.PageCache.Application do
  @moduledoc """
  PageCache Application.
  """

  use Application

  alias Plug.PageCache.Config

  def start(_type, _args) do
    import Supervisor.Spec

    options = [ strategy: :one_for_one, name: __MODULE__.Supervisor ]

    Supervisor.start_link(cache_workers(), options)
  end

  defp cache_workers do
    import Supervisor.Spec

    Enum.map Config.caches, fn ({ name, opts }) ->
      id   = Config.cache_id(name)
      opts = Keyword.merge(opts, [ id: id, name: name ])

      worker(opts[:adapter], [ opts ], id: id)
    end
  end
end
