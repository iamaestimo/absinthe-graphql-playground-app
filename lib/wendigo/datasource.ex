defmodule Wendigo.Datasource do
  @moduledoc false
  alias Wendigo.Repo

  @doc "Defines a new ecto data source"
  def new, do: Dataloader.Ecto.new(Repo)
end
