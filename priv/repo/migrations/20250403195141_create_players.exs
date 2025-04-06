defmodule Wendigo.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players, primary_key: false) do
      add :id, :string, size: 21, primary_key: true
      add :name, :text, null: false
      add :contact, :text, null: false
      add :usahn, :text
      add :jersey_number, :text
      add :position, :text
      add :team_id, references(:teams, type: :string), size: 21, null: false
      timestamps()
    end

    create index(:players, [:team_id])
  end
end
