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
    broadcast! socket, "is_in:true", %{sent_msg: inspect(msg)}
    {:reply, {:ok, %{msg: "in"}}, assign(socket, :dude, "assigned")}
  end

  def handle_in("punch:out", msg, socket) do
    IO.puts"Punched Out"
    broadcast! socket, "is_in:false", %{sent_msg: inspect(msg)}
    {:reply, {:ok, %{msg: "out"}}, assign(socket, :dude, "assigned")}
  end

  def handle_in("tc:toggle", msg, socket) do
    user = Tk.Repo.get!(Tk.User, msg["user_id"])
    IO.puts "((((((((((((((((((((((((((((((((((((((((((((("
    IO.puts inspect(user)
    IO.puts inspect(user.id)
    IO.puts inspect(user.tc)
    IO.puts "((((((((((((((((((((((((((((((((((((((((((((("
    case Tk.Repo.update( Tk.User.changeset(user, %{ tc: !user.tc }) ) do
      {:ok, user} ->
        IO.puts"tc:toggle #{user.tc}"
        broadcast! socket, "tc:#{user.tc}", %{sent_msg: inspect(msg)}
        {:reply, {:ok, %{msg: "hi"}}, assign(socket, :dude, "assigned")}
      {:error, changeset} ->
        IO.puts" ERROR tc:toggle #{user[:tc]}"
        broadcast! socket, "tc:#{user.tc}", %{sent_msg: inspect(msg)}
        {:reply, {:ok, %{msg: "hi"}}, assign(socket, :dude, "assigned")}
      _ ->
        IO.puts" ERROR ERROR tc:toggle #{user[:tc]}"
        broadcast! socket, "tc:#{user.tc}", %{sent_msg: inspect(msg)}
        {:reply, {:ok, %{msg: "hi"}}, assign(socket, :dude, "assigned")}
    end
  end


end
