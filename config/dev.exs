import Config

# Example CORS for localhost
# config :cors_plug,
#  origin: ["http://localhost:5173", "localhost"],
#  max_age: 86400,
#  methods: ["GET", "POST"]

# Database
config :wendigo, Wendigo.Repo,
  username: "postgres",
  password: "password1",
  hostname: "localhost",
  database: "wendigo_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 4

# Endpoint
config :wendigo, WendigoWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 8085],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "JnTHN0/jBmHg74CY5zYwpmK15fRY0ZkIq48Fz/6DHzFz6j6vmcvrBDylQdUwnhJi",
  watchers: []

# Other
config :wendigo, dev_routes: true
config :logger, :console, format: "[$level] $message\n"
config :phoenix, :stacktrace_depth, 20
config :phoenix, :plug_init_mode, :runtime
