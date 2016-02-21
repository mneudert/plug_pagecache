defmodule Plug.PageCache.Application do
  @moduledoc """
  PageCache Application.
  """

  use Application

  def start(_type, _args) do
    { :ok, self }
  end
end
