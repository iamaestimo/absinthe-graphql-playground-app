defmodule WendigoWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :wendigo

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_wendigo_key",
    signing_salt: "ygNiN596",
    same_site: "Lax"
  ]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :wendigo,
    gzip: false,
    only: WendigoWeb.static_paths()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :wendigo
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()
    
  plug Absinthe.Plug,
    schema: WendigoWeb.GraphQL.Schema

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug WendigoWeb.Router
end
