defmodule MyChatApp.ChatRoom do
  use GenServer

  defmodule State, do: defstruct [:name, :topic]

  def start_link(room_name) do
    GenServer.start_link(__MODULE__, %State{name: room_name}, name: via_name(room_name))
  end

  def set_topic(room_name, new_topic) do
    via_name(room_name)
    |> GenServer.cast({:set_topic, new_topic})
  end

  def get_topic(room_name) do
    via_name(room_name)
    |> GenServer.call(:get_topic)
  end

  def join_room(room_name, username) do
    Registry.register(ChatRoomMessages, room_name, username)
    via_name(room_name)
    |> GenServer.cast({:room_joined, username, self})
  end

  def broadcast(room_name, message) do
    Registry.dispatch(ChatRoomMessages, room_name, fn entries ->
      entries
      |> Enum.each(fn {pid, _username} ->
        send pid, {:message, message}
      end)
    end)
  end

  def handle_cast({:set_topic, new_topic}, state) do
    {:noreply, %{state | topic: new_topic}}
  end

  def handle_cast({:room_joined, username, user_pid}, state) do
    send user_pid, {:message,
      "Hello #{username}, welcome to room #{state.name}. The current topic is '#{state.topic}'."}
    {:noreply, state}
  end

  def handle_call(:get_topic, _from, state) do
    {:reply, state.topic, state}
  end

  defp via_name(name) do
    {:via, Registry, {ChatRooms, name}}
  end
end
