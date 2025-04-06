defmodule Wendigo.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams, primary_key: false) do
      add :id, :string, size: 21, primary_key: true
      add :name, :text, null: false
      add :captain, :text
      add :season_id, references(:seasons, type: :string), size: 21, null: false
      add :league_id, references(:leagues, type: :string), size: 21, null: false
      timestamps()
    end

    create index(:teams, [:season_id, :league_id])
  end
end
