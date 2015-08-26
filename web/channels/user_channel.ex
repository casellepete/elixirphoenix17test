defmodule Tk.UserChannel do
  use Phoenix.Channel
  require Logger

  def join("user:" <> _user_id, message, socket) do
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
    user = Tk.Repo.get!(Tk.User, msg["user_id"])
    case Tk.Repo.update( Tk.User.changeset(user, %{ is_in: true }) ) do
      {:ok, user} ->
        IO.puts"Punched In"
        broadcast! socket, "is_in:true", %{sent_msg: inspect(msg)}
        {:reply, {:ok, %{msg: "out"}}, assign(socket, :dude, "assigned")}
      {:error, changeset} ->
        IO.puts" ERROR punchin in_out: #{user.is_in}"
        broadcast! socket, "is_in:true", %{sent_msg: inspect(msg)}
        {:reply, {:ok, %{msg: "out"}}, assign(socket, :dude, "assigned")}
      _ ->
        IO.puts" ERROR punchin in_out: #{user.is_in}"
        broadcast! socket, "is_in:true", %{sent_msg: inspect(msg)}
        {:reply, {:ok, %{msg: "out"}}, assign(socket, :dude, "assigned")}
    end
  end

  def handle_in("punch:out", msg, socket) do
    user = Tk.Repo.get!(Tk.User, msg["user_id"])
    case Tk.Repo.update( Tk.User.changeset(user, %{ is_in: false }) ) do
      {:ok, user} ->
        IO.puts"Punched Out"
        broadcast! socket, "is_in:false", %{sent_msg: inspect(msg)}
        {:reply, {:ok, %{msg: "out"}}, assign(socket, :dude, "assigned")}
      {:error, changeset} ->
        IO.puts" ERROR punchout in_out: #{user.is_in}"
        broadcast! socket, "is_in:false", %{sent_msg: inspect(msg)}
        {:reply, {:ok, %{msg: "out"}}, assign(socket, :dude, "assigned")}
      _ ->
        IO.puts" ERROR punchout in_out: #{user.is_in}"
        broadcast! socket, "is_in:false", %{sent_msg: inspect(msg)}
        {:reply, {:ok, %{msg: "out"}}, assign(socket, :dude, "assigned")}
    end
  end

  def handle_in("tc:toggle", msg, socket) do
    user = Tk.Repo.get!(Tk.User, msg["user_id"])
    case Tk.Repo.update( Tk.User.changeset(user, %{ tc: !user.tc }) ) do
      {:ok, user} ->
        IO.puts"tc:toggle #{user.tc}"
        broadcast! socket, "tc:#{user.tc}", %{sent_msg: inspect(msg)}
        {:reply, {:ok, %{msg: "hi"}}, assign(socket, :dude, "assigned")}
      {:error, changeset} ->
        IO.puts" ERROR tc:toggle #{user.tc}"
        broadcast! socket, "tc:#{user.tc}", %{sent_msg: inspect(msg)}
        {:reply, {:ok, %{msg: "hi"}}, assign(socket, :dude, "assigned")}
      _ ->
        IO.puts" ERROR ERROR tc:toggle #{user.tc}"
        broadcast! socket, "tc:#{user.tc}", %{sent_msg: inspect(msg)}
        {:reply, {:ok, %{msg: "hi"}}, assign(socket, :dude, "assigned")}
    end
  end

  def handle_in("update:comment", msg, socket) do
    IO.puts "(((((((((((((((((((((((((((((("
    IO.puts inspect(msg)
    IO.puts "(((((((((((((((((((((((((((((("
    user = Tk.Repo.get!(Tk.User, msg["user_id"])
    case Tk.Repo.update( Tk.User.changeset(user, %{ comment: msg["comment"] }) ) do
      {:ok, user} ->
        IO.puts"update:comment #{user.comment}"
        broadcast! socket, "updated:comment", %{comment: user.comment}
        {:reply, {:ok, %{msg: "hi"}}, assign(socket, :dude, "assigned")}
      {:error, changeset} ->
        IO.puts" ERROR update:comment #{user.comment}"
        broadcast! socket, "updated:comment", %{sent_msg: inspect(msg)}
        {:reply, {:ok, %{msg: "hi"}}, assign(socket, :dude, "assigned")}
      _ ->
        IO.puts" ERROR ERROR update:comment #{user.comment}"
        broadcast! socket, "updated:comment", %{sent_msg: inspect(msg)}
        {:reply, {:ok, %{msg: "hi"}}, assign(socket, :dude, "assigned")}
    end
  end


end
