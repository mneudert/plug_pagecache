defmodule Plug.PageCache.Adapter.ETSTest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureIO

  alias Plug.PageCache.Adapter.ETS

  test "warning if configuration is faulty" do
    opts = [ name: :faulty_config ]
    log  = capture_io :user, fn ->
      ETS.start_link(opts)
    end

    assert String.contains?(log, to_string(opts[:name]))
  end
end
