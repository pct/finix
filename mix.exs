defmodule Nix4.MixProject do
  use Mix.Project

  def project do
    [
      app: :nix4,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.0 or ~> 2.2.2 or ~> 2.3", optional: true},
      {:plug, "~> 1.5.0"},
      {:http_router, "~> 0.10.0"},
      {:linguist, "~> 0.1.5"},
      {:earmark, "~> 1.2.5"},
      {:ex_doc, "~> 0.18.3"},
      {:excoveralls, "~> 0.8.1"},
      {:dialyxir, "~> 0.5.1"},
      {:jason, "~> 1.0.0"},
      {:gettext, "~> 0.15.0"},
      {:phoenix_html, "~> 2.11.1"},
      {:inch_ex, "~> 0.5.4"},
      {:credo, "~> 0.9.0"},
      {:slime, "~> 1.1.0"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
