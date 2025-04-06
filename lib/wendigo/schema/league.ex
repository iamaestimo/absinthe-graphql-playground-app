defmodule Wendigo.Schema.League do
  @moduledoc """
  Schema for the `leagues` table.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: %__MODULE__{}

  @primary_key {:id, :string, autogenerate: {Ecto.Nanoid, :autogenerate, []}}
  schema "leagues" do
    field :name, :string
    field :level, :string
    timestamps()
  end

  @doc "Creates a changeset for a league"
  def changeset(params), do: changeset(%__MODULE__{}, params)

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :level])
    |> validate_required([:name])
    |> validate_length(:name, max: 100)
    |> validate_length(:level, max: 100)
  end
end
