# .iex.exs
# Configure IEx project settings

# Common imports used frequently
import Enum, only: [map: 2, reduce: 3, filter: 2]
import String, only: [upcase: 1, downcase: 1]

# Project imports for ad-hoc testing
alias Wendigo.Context.{Leagues, Seasons, Teams}
alias Wendigo.Repo
alias Wendigo.Schema.{League, Player, Season, Team}

# Configure shell appearance
Application.put_env(:elixir, :ansi_enabled, true)

IEx.configure(
  history_size: 100,
  inspect: [
    limit: 5_000,
    pretty: true,
    width: 80
  ],
  colors: [
    syntax_colors: [
      number: :blue,
      atom: :cyan,
      string: :green,
      boolean: :red,
      nil: :red
    ],
    eval_result: [:green, :bright],
    eval_error: [:red, :bright],
    eval_info: [:blue, :bright]
  ],
  default_prompt:
    "#{IO.ANSI.green()}%prefix#{IO.ANSI.reset()}" <>
      "(#{IO.ANSI.cyan()}%counter#{IO.ANSI.reset()}) >"
)
