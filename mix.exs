defmodule Finix.MixProject do
  use Mix.Project

  def project do
    [
      app: :finix,
      version: "0.1.0",
      elixir: "~> 1.6",
      name: "Finix",
      source_url: "https://github.com/pct/finix",
      #homepage_url: "",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: [readme: "README.md", main: "README"],
      test_coverage: [tool: ExCoveralls]
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
      {:ecto, "~> 2.2.9"},
      {:mariaex, "~> 0.8.4"},
      {:http_router, "~> 0.10.0"},
      {:jason, "~> 1.0.0"},
      {:inch_ex, "~> 0.5.4"},
      {:credo, "~> 0.9.0"},
      {:expug, "~> 0.9"},
      {:exi18n, "~> 0.8.0"},
      {:yaml_elixir, "~> 1.3.0"},
      {:earmark, "~> 1.2.5", only: :docs},
      {:ex_doc, "~> 0.18.3", only: :docs},
      {:excoveralls, "~> 0.8.1", only: :test},
      {:dialyxir, "~> 0.5.1", only: :test},
      {:exsync, "~> 0.2", only: :dev}
    ]
  end

  defp package do
		%{maintainers: ["Jin-Sih, Lin"],
			files: ["lib",  "mix.exs", "README.md", "LICENSE"],
			licenses: ["MIT"],
			links: %{"GitHub" => "https://github.com/pct/finix"}}
  end
end
