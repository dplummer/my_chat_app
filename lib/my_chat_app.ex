defmodule MyChatApp do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Registry, [:unique, ChatRooms]),
      supervisor(MyChatApp.ChatRoomsSupervisor, []),
    ]
    opts = [strategy: :one_for_one, name: MyChatApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
