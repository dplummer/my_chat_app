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

  def handle_cast({:set_topic, new_topic}, state) do
    {:noreply, %{state | topic: new_topic}}
  end

  def handle_call(:get_topic, _from, %State{topic: topic} = state) do
    {:reply, topic, state}
  end

  defp via_name(name) do
    {:via, Registry, {ChatRooms, name}}
  end
end
