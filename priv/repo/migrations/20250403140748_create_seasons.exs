defmodule Wendigo.Repo.Migrations.CreateSeasons do
  use Ecto.Migration

  def change do
    create table(:seasons, primary_key: false) do
      add :id, :string, size: 21, primary_key: true
      add :name, :text, null: false
      add :start_date, :date, null: false
      add :end_date, :date, null: false
      timestamps()
    end

    create index(:seasons, [:start_date])
  end
end
