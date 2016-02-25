use Mix.Config

config :plug_pagecache,
  :caches,
    foo: [ adapter: Plug.PageCache.Adapter.ETS ],
    bar: [ adapter: Plug.PageCache.Adapter.ETS ]
