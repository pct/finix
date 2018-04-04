defmodule Nix4.MixProject do
  use Mix.Project

  def project do
    [
      app: :nix4,
      version: "0.1.0",
      elixir: "~> 1.6",
      name: "4Nix",
      source_url: "https://github.com/pct/4nix",
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
      {:phoenix_html, "~> 2.11.1"},
      {:inch_ex, "~> 0.5.4"},
      {:credo, "~> 0.9.0"},
      {:slime, "~> 1.1.0"},
      {:exi18n, "~> 0.8.0"},
      {:yaml_elixir, "~> 1.3.0"},
      {:earmark, "~> 1.2.5", only: :docs},
      {:ex_doc, "~> 0.18.3", only: :docs},
      {:excoveralls, "~> 0.8.1", only: :test},
      {:dialyxir, "~> 0.5.1", only: :test},
    ]
  end

  defp package do
		%{maintainers: ["Jin-Sih, Lin"],
			files: ["lib",  "mix.exs", "README.md", "LICENSE"],
			licenses: ["MIT"],
			links: %{"GitHub" => "https://github.com/pct/4nix"}}
  end
end
