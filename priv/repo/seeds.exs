# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Wendigo.Repo.insert!(%Wendigo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Wendigo.Repo
alias Wendigo.Schema.{League, Player, Season, Team}

# LEAGUES
league =
  %{name: "Big Sky", level: "Advanced"}
  |> League.changeset()
  |> Repo.insert!()

[
  %{name: "Rocky Mountain", level: "Intermediate"},
  %{name: "Giants", level: "Novice"},
  %{name: "Mixed Lower", level: "Novice / Intermediate"},
  %{name: "Mixed Upper", level: "Intermediate / Advanced"}
]
|> Enum.each(fn args ->
  Repo.insert!(League.changeset(args))
end)

# SEASONS

%{
  name: "Summer 2025",
  start_date: Date.from_iso8601!("2025-06-01"),
  end_date: Date.from_iso8601!("2025-08-31")
}
|> Season.changeset()
|> Repo.insert!()

season =
  %{
    name: "Fall 2025",
    start_date: Date.from_iso8601!("2025-09-01"),
    end_date: Date.from_iso8601!("2025-12-31")
  }
  |> Season.changeset()
  |> Repo.insert!()

# TEAMS

team =
  %{name: "Team 1", captain: "Sam Smith", league_id: league.id, season_id: season.id}
  |> Team.changeset()
  |> Repo.insert!()

%{name: "Team 2", captain: "Joe Jones", league_id: league.id, season_id: season.id}
|> Team.changeset()
|> Repo.insert!()

# PLAYERS

%{
  name: "Sam Smith",
  contact: "(406) 555-1234",
  usahn: "1XXXXXXXXXXXXV",
  jersey_number: "72",
  position: "Defense",
  team_id: team.id
}
|> Player.changeset()
|> Repo.insert!()

%{
  name: "Dan Davidson",
  contact: "(414) 555-3579",
  usahn: "2XXXXXXXXXXXXW",
  jersey_number: "37",
  position: "Goalie",
  team_id: team.id
}
|> Player.changeset()
|> Repo.insert!()

%{
  name: "Hans Gruber",
  contact: "(612) 555-2468",
  usahn: "3XXXXXXXXXXXXY",
  jersey_number: "19",
  position: "Center",
  team_id: team.id
}
|> Player.changeset()
|> Repo.insert!()

%{
  name: "Evan Evans",
  contact: "(310) 555-9876",
  usahn: "4XXXXXXXXXXXXZ",
  jersey_number: "93",
  position: "Wing",
  team_id: team.id
}
|> Player.changeset()
|> Repo.insert!()
