use Mix.Config

config :plug_pagecache,
  :caches,
    agent: [
      adapter: Plug.PageCache.Adapter.Agent
    ],
    ets: [
      adapter: Plug.PageCache.Adapter.ETS,
      table:   :plug_pagecache_foo
    ]
