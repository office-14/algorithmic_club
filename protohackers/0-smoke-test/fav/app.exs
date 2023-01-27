defmodule EchoServer do
  @port 8888

  def listen do
    {:ok, socket} =
      :gen_tcp.listen(@port, [mode: :binary, active: false, reuseaddr: true, exit_on_close: false])
  end

  def process_connections(socket) do
    {:ok, sock} = :gen_tcp.accept(socket)

    Task.async(fn ->
      {:ok,data} = receve_until_closed(sock)
      IO.inspect("res: #{data}")
      case(:gen_tcp.send(sock, data)) do
        :ok -> IO.inspect("send OK")
        {:error, :closed} -> IO.inspect("closed when sending")
      end

      ok = :gen_tcp.close(sock)
    end)

    process_connections(socket)
  end

  def receve_until_closed(sock, data \\ "") do
    case(:gen_tcp.recv(sock, 0)) do
      {:ok, resp} ->
        IO.inspect("got #{resp}")
        receve_until_closed(sock, data <> resp)

      {:error, :closed} ->
        {:ok, data}

        other -> IO.inspect("got other: #{other}")
    end
  end

  def close(socket) do
    ok = :gen_tcp.close(socket)
  end
end

{:ok, socket} = EchoServer.listen()
EchoServer.process_connections(socket)

System.at_exit(fn _status ->
  EchoServer.close(socket)
  IO.puts("Bye!")
end)
