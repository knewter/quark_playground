defmodule QuarkPlayground.Mixfile do
  use Mix.Project

  def project do
    [app: :quark_playground,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger]]
  end

  def deps do
    [
      {:quark, "~> 2.1"}
    ]
  end
end
