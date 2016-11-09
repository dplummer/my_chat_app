defmodule MyChatApp do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Registry, [:unique, ChatRooms], id: :chat_rooms),
      worker(Registry, [:duplicate, ChatRoomMessages], id: :chat_room_messages),
      supervisor(MyChatApp.ChatRoomsSupervisor, []),
      worker(Registry, [:unique, ChatUsers], id: :chat_users),
      supervisor(MyChatApp.UsersSupervisor, []),
    ]
    opts = [strategy: :one_for_one, name: MyChatApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
