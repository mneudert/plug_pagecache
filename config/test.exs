use Mix.Config

config :plug_pagecache,
  :caches,
    ets: [
      adapter: Plug.PageCache.Adapter.ETS,
      table:   :plug_pagecache_foo
    ]
