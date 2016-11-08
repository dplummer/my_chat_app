defmodule MyChatApp.ChatRoomsSupervisor do
  def start_link do
    import Supervisor.Spec

    [
      worker(MyChatApp.ChatRoom, [])
    ]
    |> Supervisor.start_link(strategy: :simple_one_for_one, name: __MODULE__)
  end

  def open_room(name) do
    Supervisor.start_child(__MODULE__, [name])
  end
end
