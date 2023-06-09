defmodule DoNothingDsl.MixProject do
  use Mix.Project

  def project do
    [
      app: :do_nothing_dsl,
      version: "0.1.0",
      elixir: "~> 1.14",
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
     {:spark, "~> 1.1.13"},
     {:do_nothing, github: "erikareads/do_nothing", tag: "v0.1.0"}
    ]
  end
end
