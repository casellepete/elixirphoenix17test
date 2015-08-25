defmodule Tk.UserChannel do
  use Phoenix.Channel
  require Logger

  def join("user:" <> _user_id, message, socket) do
    IO.puts "WWWWWWWWWWWWWWWWWWWWWWWEEEEEEEEEEEEEEEEEEE are here"
    {:ok, socket }
  end

  def handle_info({:after_join, msg}, socket) do
    broadcast! socket, "user:connectified", %{thingone: "thingtwo"}
  end

  def terminate(reason, _socket) do
    Logger.debug"> leave #{inspect reason}"
    :ok
  end

  def handle_in("punch:in", msg, socket) do
    IO.puts"Punched In"
    broadcast! socket, "punched:in", %{punched: inspect(msg)}
    {:reply, {:ok, %{msg: "in"}}, assign(socket, :dude, "assigned")}
  end

  def handle_in("punch:out", msg, socket) do
    IO.puts"Punched Out"
    broadcast! socket, "punched:out", %{punched: inspect(msg)}
    {:reply, {:ok, %{msg: "out"}}, assign(socket, :dude, "assigned")}
  end


end
