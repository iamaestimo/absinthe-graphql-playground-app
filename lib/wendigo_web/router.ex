defmodule WendigoWeb.Router do
  use WendigoWeb, :router

  pipeline :api do
    plug CORSPlug
    plug :accepts, ["json"]
  end

  scope "/wendigo/api" do
    pipe_through :api

    # Only show GraphiQL in development
    if Mix.env() == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL, schema: WendigoWeb.Schema
    end

    forward "/graphql", Absinthe.Plug, schema: WendigoWeb.Schema
  end
end
