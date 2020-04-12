defmodule HLS.Plg.MixProject do
  use Mix.Project

  def project do
    [
      app: :hls_playlist_generator,
      version: "0.1.0",
      elixir: "~> 1.9",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package()
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
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp description do
    "Generator of all available m3u8 playlist types for HLS protocol with a minimal valid set of the attributes."
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "CHANGELOG*", "LICENSE*"],
      maintainers: ["Ivan Zabrovskiy"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/Loriowar/hls_playlist_generator"}
    ]
  end
end
