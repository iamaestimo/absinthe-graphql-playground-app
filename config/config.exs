import Config

# General
config :wendigo,
  ecto_repos: [Wendigo.Repo],
  generators: [timestamp_type: :utc_datetime],
  min_page_size: 10,
  max_page_size: 100

# Endpoint
config :wendigo, WendigoWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: WendigoWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Wendigo.PubSub,
  live_view: [signing_salt: "CMKFl/Hw"]

# Logging
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# JSON
config :phoenix, :json_library, Jason

# Custom ID types
config :nanoid,
  size: 21,
  alphabet: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

# Import environment specific config.
# NOTE: This must remain at the bottom of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

import_config "appsignal.exs"
