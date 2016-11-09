defmodule MyChatApp.User do
  use GenServer

  defmodule State, do: defstruct [:name]

  def start_link(username) do
    GenServer.start_link(__MODULE__, %State{name: username}, name: via_name(username))
  end

  def join_room(username, room_name) do
    via_name(username)
    |> GenServer.call({:join_room, room_name})
  end

  def handle_call({:join_room, room_name}, _from, state) do
    MyChatApp.ChatRoom.join_room(room_name, state.name)
    {:reply, :ok, state}
  end

  def handle_info({:message, message}, state) do
    IO.puts "[#{state.name}] received message: #{message}"
    {:noreply, state}
  end

  defp via_name(username) do
    {:via, Registry, {ChatUsers, username}}
  end
end
