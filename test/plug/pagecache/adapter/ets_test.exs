defmodule Plug.PageCache.Adapter.ETSTest do
  use ExUnit.Case, async: false

  import ExUnit.CaptureLog

  alias Plug.PageCache.Adapter.ETS

  test "warning if configuration is faulty" do
    opts = [name: :faulty_config]

    log =
      capture_log(fn ->
        ETS.start_link(opts)
        :timer.sleep(50)
      end)

    assert String.contains?(log, to_string(opts[:name]))
  end
end
