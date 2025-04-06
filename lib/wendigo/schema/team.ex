defmodule Wendigo.Schema.Team do
  @moduledoc """
  Schema for the `teams` table.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Wendigo.Schema.{League, Player, Season}

  @type t() :: %__MODULE__{}

  @primary_key {:id, :string, autogenerate: {Ecto.Nanoid, :autogenerate, []}}
  schema "teams" do
    field :name, :string
    field :captain, :string
    belongs_to(:league, League, type: Ecto.Nanoid)
    belongs_to(:season, Season, type: Ecto.Nanoid)
    has_many(:players, Player)
    timestamps()
  end

  @doc "Creates a changeset for a team"
  def changeset(params), do: changeset(%__MODULE__{}, params)

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :captain, :league_id, :season_id])
    |> validate_required([:name, :league_id, :season_id])
    |> validate_length(:name, max: 100)
    |> validate_length(:captain, max: 100)
    |> foreign_key_constraint(:league_id)
    |> foreign_key_constraint(:season_id)
  end
end
