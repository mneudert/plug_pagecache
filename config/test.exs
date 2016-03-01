use Mix.Config

config :plug_pagecache,
  :caches,
    foo: [
      adapter: Plug.PageCache.Adapter.ETS,
      table:   :plug_pagecache_foo
    ],
    bar: [
      adapter: Plug.PageCache.Adapter.ETS,
      table:   :plug_pagecache_bar
    ]
