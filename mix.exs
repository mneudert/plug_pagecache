defmodule Plug.PageCache.Mixfile do
  use Mix.Project

  @url_github "https://github.com/mneudert/plug_pagecache"

  def project do
    [ app:     :plug_pagecache,
      name:    "Plug.PageCache",
      version: "0.3.0-dev",
      elixir:  "~> 1.2",
      deps:    deps(),

      build_embedded:  Mix.env == :prod,
      start_permanent: Mix.env == :prod,

      preferred_cli_env: [
        coveralls:          :test,
        'coveralls.detail': :test,
        'coveralls.travis': :test
      ],

      description:   "Plug for full page response caching",
      docs:          docs(),
      package:       package(),
      test_coverage: [ tool: ExCoveralls ] ]
  end

  def application do
    [ applications: [ :logger ],
      mod:          { Plug.PageCache.Application, [] } ]
  end

  defp deps do
    [ { :ex_doc,      ">= 0.0.0", only: :dev },
      { :excoveralls, "~> 0.6",   only: :test },

      { :cowboy, "~> 1.0", optional: true },
      { :plug,   "~> 1.0", optional: true } ]
  end

  defp docs do
    [ extras:     [ "CHANGELOG.md", "README.md" ],
      main:       "readme",
      source_ref: "master",
      source_url: @url_github ]
  end

  defp package do
    %{ files:       [ "CHANGELOG.md", "LICENSE", "mix.exs", "README.md", "lib" ],
       licenses:    [ "Apache 2.0" ],
       links:       %{ "GitHub" => @url_github },
       maintainers: [ "Marc Neudert" ] }
  end
end
