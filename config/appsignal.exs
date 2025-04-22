import Config

config :appsignal, :config,
  otp_app: :wendigo,
  name: "wendigo_app",
  push_api_key: System.get_env("APPSIGNAL_PUSH_API_KEY"),
  env: Mix.env
