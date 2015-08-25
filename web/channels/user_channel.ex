defmodule Tk.UserChannel do
  use Phoenix.Channel
  require Logger

  def join("tk:" <> _user_id, _message, _socket) do
    {:error, %{reason: "seagulls are slow, user_id: *#{_user_id}*, message: *#{_message}*"}}
  end

  def handle_info({:after_join, msg}, socket) do
    broadcast! socket, "user:connectified", %{thingone: "thingtwo"}
  end

  def terminate(reason, _socket) do
    Logger.debug"> leave #{inspect reason}"
    :ok
  end

  def handle_in("new:msg", msg, socket) do
    broadcast! socket, "new:msg", %{thingthree: "thingfour"}
    {:reply, {:ok, %{msg: inspect(msg)}}, assign(socket, :dude, "assigned")}
  end


end
