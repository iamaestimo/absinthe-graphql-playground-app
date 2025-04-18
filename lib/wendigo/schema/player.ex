defmodule Wendigo.Schema.Player do
  @moduledoc """
  Schema for the `players` table.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Wendigo.Schema.Team

  @type t() :: %__MODULE__{}

  @primary_key {:id, :string, autogenerate: {Ecto.Nanoid, :autogenerate, []}}
  schema "players" do
    field :name, :string
    field :contact, :string
    field :usahn, :string
    field :jersey_number, :string
    field :position, :string
    belongs_to(:team, Team, type: Ecto.Nanoid)
    timestamps()
  end

  @doc "Creates a changeset for a player"
  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :contact, :usahn, :jersey_number, :position, :team_id])
    |> validate_required([:name, :contact, :team_id])
    |> validate_length(:name, max: 100)
    |> validate_length(:contact, max: 100)
    |> validate_length(:usahn, max: 100)
    |> validate_length(:jersey_number, max: 100)
    |> validate_length(:position, max: 100)
    |> foreign_key_constraint(:team_id)
  end

  def changeset(params),
    do: changeset(%__MODULE__{}, params)
end
