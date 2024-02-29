defmodule ExAws.ECR.MixProject do
  use Mix.Project

  @name ExAws.ECR
  @version "0.1.0"
  @url "https://github.com/fendent/ex_aws_ecr"
  @licenses ["MIT"]
  @maintainers ["Sean Murphy"]

  def project do
    [
      app: :ex_aws_ecr,
      name: @name,
      version: @version,
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      source_url: @url,
      homepage_url: @url
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:hackney, ">= 0.0.0", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:credo, "~> 1.1", only: [:dev, :test], runtime: false},
      ex_aws()
    ]
  end

  defp description do
    "#{@name} service package"
  end

  defp package do
    [
      files: ~w(lib test mix.exs .formatter.exs README* LICENSE* CHANGELOG*),
      maintainers: @maintainers,
      licenses: @licenses,
      links: %{"GitHub" => @url}
    ]
  end

  defp ex_aws() do
    case System.get_env("AWS") do
      "LOCAL" -> {:ex_aws, path: "../ex_aws"}
      _ -> {:ex_aws, "~> 2.0"}
    end
  end
end
