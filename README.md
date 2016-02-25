# Plug.PageCache

Plug for full page response caching.


## Configuration

Define your caches in your `config.exs`:

```elixir
use Mix.Config

config :plug_pagecache,
  :caches,
    my_cache: [ adapter: Plug.PageCache.Adapter.ETS ]
```


## License

[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)
