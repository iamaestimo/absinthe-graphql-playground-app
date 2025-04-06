import Config

# Database
config :wendigo, Wendigo.Repo,
  username: "postgres",
  password: "password1",
  hostname: "localhost",
  database: "wendigo_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# Endpoint (disabled)
config :wendigo, WendigoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 8086],
  secret_key_base: "3RacJ/AblbAwHIuMJI5XMlJ1LVOEIUt2cxfLyXZ8wZftxSNO5Enev3gPvIdl+qeS",
  server: false

# Other
config :logger, level: :warning
config :phoenix, :plug_init_mode, :runtime
