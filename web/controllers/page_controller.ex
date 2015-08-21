defmodule Tk.PageController do
  use Tk.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
