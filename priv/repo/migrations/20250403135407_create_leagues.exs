defmodule Wendigo.Repo.Migrations.CreateLeagues do
  use Ecto.Migration

  def change do
    create table(:leagues, primary_key: false) do
      add :id, :string, size: 21, primary_key: true
      add :name, :text, null: false
      add :level, :text
      timestamps()
    end

    create index(:leagues, [:inserted_at])
  end
end
