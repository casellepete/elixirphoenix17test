defmodule Tk.Router do
  use Tk.Web, :router

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

  scope "/", Tk do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    get "/punchin/:id", UserController, :punchin
    get "/punchout/:id", UserController, :punchout
  end


  # Other scopes may use custom stacks.
  # scope "/api", Tk do
  #   pipe_through :api
  # end
end
