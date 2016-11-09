defmodule MyChatApp.UsersSupervisor do
  def start_link do
    import Supervisor.Spec

    [
      worker(MyChatApp.User, [])
    ]
    |> Supervisor.start_link(strategy: :simple_one_for_one, name: __MODULE__)
  end

  def connect_user(name) do
    Supervisor.start_child(__MODULE__, [name])
  end
end
