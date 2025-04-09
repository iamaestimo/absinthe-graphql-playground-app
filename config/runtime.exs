import Config

# NOTE: Use `mix phx.gen.release` to generate a `bin/server` script that automatically
# sets `PHX_SERVER`.
if System.get_env("PHX_SERVER") do
  config :wendigo, WendigoWeb.Endpoint, server: true
end

if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_URL") ||
      raise "Environment variable DATABASE_URL is missing. Ex: ecto://USER:PASS@HOST/DATABASE"

  maybe_ipv6 = if System.get_env("ECTO_IPV6") in ~w(true 1), do: [:inet6], else: []

  config :wendigo, Wendigo.Repo,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
    socket_options: maybe_ipv6

  # NOTE: can generate with: `mix phx.gen.secret`
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise "Environment variable SECRET_KEY_BASE is missing."

  host = System.get_env("PHX_HOST") || "wendigo.io"
  port = String.to_integer(System.get_env("PORT") || "8080")

  config :wendigo, :dns_cluster_query, System.get_env("DNS_CLUSTER_QUERY")

  config :wendigo, WendigoWeb.Endpoint,
    url: [host: host, port: 443, scheme: "https", path: "/wendigo"],
    http: [ip: {0, 0, 0, 0}, port: port],
    secret_key_base: secret_key_base
end
