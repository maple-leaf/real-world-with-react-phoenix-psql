defmodule AppWeb.Router do
  use AppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  defp verify_auth(conn, _) do
    userId = conn
             |> fetch_session
             |> get_session(:user_id)
    if userId do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> text(:unauthorized)
      |> halt()
    end
  end
  pipeline :auth_verify do
    plug :verify_auth
  end

  scope "/", AppWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    # get "/*path", PageController, :index
  end

  scope "/", AppWeb do
    post "/signin", AuthController, :signin
    post "/signout", AuthController, :signout
    post "/register", AuthController, :register
  end

  # Other scopes may use custom stacks.
  scope "/api", AppWeb do
    pipe_through :api
    pipe_through :auth_verify

    get "/test", AuthController, :test
  end
end
