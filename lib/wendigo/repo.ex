defmodule Wendigo.Repo do
  @moduledoc false
  use Ecto.Repo,
    otp_app: :wendigo,
    adapter: Ecto.Adapters.Postgres
end
