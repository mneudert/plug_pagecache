defmodule Plug.PageCache do
  @moduledoc """
  PageCache Plug
  """

  @behaviour Plug

  def init(opts), do: opts |> Enum.into(%{})

  def call(conn, _opts), do: conn
end
