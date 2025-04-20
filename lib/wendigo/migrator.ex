defmodule Wendigo.Migrator do
  @moduledoc """
  Runs ecto migrations.
  """
  require Application

  def run do
    {:ok, _} = Application.ensure_all_started(:wendigo)
    path = Application.app_dir(:wendigo, "priv/repo/migrations")
    Ecto.Migrator.run(Wendigo.Repo, path, :up, all: true)
    :init.stop()
  end
end
