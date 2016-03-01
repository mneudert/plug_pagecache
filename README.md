# Plug.PageCache

Plug for full page response caching.


## Configuration

Define your caches in your `config.exs`:

```elixir
use Mix.Config

config :plug_pagecache,
  :caches,
    my_agent_cache: [
      adapter: Plug.PageCache.Adapter.Agent
    ],
    my_ets_cache: [
      adapter: Plug.PageCache.Adapter.ETS,
      table:   :my_ets_table
    ]
```


## License

[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)
