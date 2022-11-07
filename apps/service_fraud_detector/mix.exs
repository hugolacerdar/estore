defmodule ServiceFraudDetector.MixProject do
  use Mix.Project

  def project do
    [
      app: :service_fraud_detector,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ServiceFraudDetector.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:serializer, in_umbrella: true},
      {:broadway_kafka, "~> 0.4"}
    ]
  end
end
