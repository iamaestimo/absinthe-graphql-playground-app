defmodule WendigoWeb.Schema.Types do
  @moduledoc """
  GraphQL schema type definitions.
  """
  use Absinthe.Schema.Notation

  alias Wendigo.Context.{Leagues, Seasons, Teams}
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :league do
    field :id, :id
    field :name, :string
    field :level, :string
  end

  object :season do
    field :id, :id
    field :name, :string
    field :start_date, :date
    field :end_date, :date
  end

  object :player do
    field :id, :id
    field :name, :string
    field :contact, :string
    field :usahn, :string
    field :jersey_number, :string
    field :position, :string
    field :team, :team, resolve: dataloader(Teams)
  end

  object :team do
    field :id, :id
    field :name, :string
    field :captain, :string
    field :league, :league, resolve: dataloader(Leagues)
    field :season, :season, resolve: dataloader(Seasons)
    field :players, list_of(:player), resolve: dataloader(Teams)
  end
end
