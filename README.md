# Plug.PageCache

Plug for full page response caching.


## Warning

__This is not the plug you are looking for!__

Well, perhaps at least. There is no "one size fits all" caching solution.

This plug should better be seen as "food for thought" or an easy way to
just plug some cache into your application and see what happens.

_Question this library might answer_:

"Would my site be any faster if the complete page would be served from memory?"


## Setup

Add the plug as a dependency to your `mix.exs` file:

```elixir
defp deps do
  [ { :plug_pagecache, "~> 0.1" } ]
end
```

You should also update your applications to include all necessary projects:

```elixir
def application do
  [ applications: [ :plug_pagecache ] ]
end
```


## Usage

### Configuration

Define your caches in your `config.exs`:

```elixir
use Mix.Config

config :plug_pagecache,
  :caches,
    my_agent_cache: [
      adapter:     Plug.PageCache.Adapter.Agent,
      auto_expire: 3600
    ],
    my_ets_cache: [
      adapter:     Plug.PageCache.Adapter.ETS,
      auto_expire: 3600,
      table:       :my_ets_table
    ]
```

Every cache is configured using an internal name as the key and a `Keyword.t`
for details. The key `:adapter` is always necessary, other configuration
values depend on the used adapter.

### Plugging

Add the cache you have configured to your plug pipeline:

```elixir
defmodule AppRouter do
  use Plug.Router

  plug Plug.PageCache, cache: :my_configured_cache

  # ...

  plug :match
  plug :dispatch

  # ...
end
```

Any `not nil` response body will be cached after dispatching using the
served path as the key. If there is a cached response available it will be
sent with the response status `200` (`OK`) to the client.

### Invalidation

As there is no automatic expiration/invalidation these things
have to be done manually:

```elixir
cache   = Config.cache_id(:my_configured_cache)
request = { :remove, "/path/to/be/invalidated" }

:ok = GenServer.call(cache, request)
```

Cleaning all entries is also possible:

```elixir
cache   = Config.cache_id(:my_configured_cache)
request = :clean

:ok = GenServer.call(cache, request)
```


## Available Adapters

### Plug.PageCache.Adapter.Agent

Uses a plain `GenServer` to serve responses directly from memory (== state).

Requires no additional configuration.

Optionally takes an `:auto_expire` value as entry lifetime in seconds.

### Plug.PageCache.Adapter.ETS

Uses an `ets table` to serve reseponses.

Responses are stored in a `:named_table` you have to configure
using the `:table` key.

Optionally takes an `:auto_expire` value as entry lifetime in seconds.


## License

[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)
