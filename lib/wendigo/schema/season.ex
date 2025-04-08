defmodule Wendigo.Schema.Season do
  @moduledoc """
  Schema for the `seasons` table.
  """
  import Ecto.Changeset
  use Ecto.Schema

  @type t() :: %__MODULE__{}

  @primary_key {:id, :string, autogenerate: {Ecto.Nanoid, :autogenerate, []}}
  schema "seasons" do
    field :name, :string
    field :start_date, :date
    field :end_date, :date
    timestamps()
  end

  @doc "Creates a changeset for a season"
  def changeset(params), do: changeset(%__MODULE__{}, params)

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :start_date, :end_date])
    |> validate_required([:name, :start_date, :end_date])
    |> validate_length(:name, max: 100)
  end
end
