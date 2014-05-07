defmodule ElixirTtt.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_ttt,
     version: "0.0.1",
     elixir: "~> 0.13.0",
     escript_main_module: Run,
     deps: deps,
     compile_path: "ebin"]
  end

  # Type `mix help compile.app` for more information
  def application do
     [ applications: [] ]
  end

  # List all dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  # Type `mix help deps` for more examples and options
  defp deps do
    []
  end
end
