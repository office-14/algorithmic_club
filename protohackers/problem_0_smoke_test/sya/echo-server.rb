require 'socket'

Socket.tcp_server_loop(8083) {|sock, client_addrinfo|
  Thread.new {
    begin
      IO.copy_stream(sock, sock)
    ensure
      sock.close
    end
  }
}
