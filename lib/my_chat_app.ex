defmodule MyChatApp do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Registry, [:unique, ChatRooms]),
      supervisor(MyChatApp.ChatRoomsSupervisor, []),
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: MyChatApp.Supervisor)
  end
end
