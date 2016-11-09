# MyChatApp

Sample chat app using `Registry` for process registration. Written in support
of talk originally given at Seattle Elixir Meetup on November 8, 2016.

## Usage

```
$ iex -S mix
Erlang/OTP 19 [erts-8.1] [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Compiling 1 file (.ex)
Interactive Elixir (1.3.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> MyChatApp.ChatRoomsSupervisor.open_room("bookclub")
{:ok, #PID<0.129.0>}
iex> MyChatApp.ChatRoom.set_topic("bookclub", "a place to learn to read gud")
:ok
iex> MyChatApp.ChatRoom.get_topic("bookclub")
"a place to learn to read gud"
```

```
iex -S mix
Erlang/OTP 19 [erts-8.1] [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Interactive Elixir (1.3.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> MyChatApp.ChatRoomsSupervisor.open_room("bookclub")
{:ok, #PID<0.158.0>}
iex> MyChatApp.ChatRoom.set_topic("bookclub", "a place to learn to read gud")
:ok
iex> ["bert", "ernie"] |> Enum.each(&MyChatApp.UsersSupervisor.connect_user/1)
:ok
iex> ["bert", "ernie"] |> Enum.each(&MyChatApp.User.join_room(&1, "bookclub"))
[bert] received message: Hello bert, welcome to room bookclub. The current topic is 'a place to learn to read gud'.
[ernie] received message: Hello ernie, welcome to room bookclub. The current topic is 'a place to learn to read gud'.
:ok
iex> MyChatApp.ChatRoom.broadcast("bookclub", "hello friends!")
[bert] received message: hello friends!
[ernie] received message: hello friends!
:ok
```
