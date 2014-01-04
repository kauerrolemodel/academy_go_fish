require 'json'

class GoFishSocketServer
  attr_reader :clients, :hands

  def initialize
    @socket_server = TCPServer.new(3333)
    @hands = []
    @clients = []
  end

  def accept_client
    @clients << @socket_server.accept
  end

  def broadcast_hands
    hands.each_with_index do |hand, index|
      @clients[index].puts(hand.to_json)
    end
  end

  def close
    @socket_server.close
  end

end
