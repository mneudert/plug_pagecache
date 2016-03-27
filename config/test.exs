use Mix.Config

config :plug_pagecache,
  :caches,
    agent: [
      adapter: Plug.PageCache.Adapter.Agent
    ],
    agent_expire: [
      adapter:     Plug.PageCache.Adapter.Agent,
      auto_expire: 1
    ],
    ets: [
      adapter: Plug.PageCache.Adapter.ETS,
      table:   :plug_pagecache_ets
    ]
