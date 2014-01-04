require 'rspec'
require 'socket'
require_relative '../go_fish_socket_server'
require_relative '../playing_card'

class MockClient
  attr_reader :output
  def initialize
    @socket = TCPSocket.new('localhost', 3333)
  end

  def provide_input(string)
    @socket.puts(string)
  end

  def capture_output
    sleep(0.1)
    @output = @socket.read_nonblock(1000)
  rescue
    @output = ""
  end
end

describe GoFishSocketServer do
  before do
    @server = GoFishSocketServer.new
  end

  after do
    @server.close
  end
  
  context "Basic set up" do
    it 'listens on port 3333 when started' do
      expect{TCPSocket.new('localhost', 3333)}.to_not raise_error
    end
  end

  context "Connecting clients" do
    it 'accepts a single client' do
      client1 = TCPSocket.new('localhost', 3333)
      @server.accept_client
      expect(@server.clients.count).to equal 1
    end
    it 'accepts multiple clients' do
      client1 = TCPSocket.new('localhost', 3333)
      client2 = TCPSocket.new('localhost', 3333)
      @server.accept_client
      @server.accept_client
      expect(@server.clients.count).to equal 2
    end
    it 'connects clients to hands' do
      client1 = MockClient.new
      client2 = MockClient.new
      @server.accept_client
      @server.accept_client
      ace = PlayingCard.new('A','S')
      @server.hands[0] = [ace]
      @server.broadcast_hands
      client1.capture_output
      expect(client1.output).to include @server.hands[0].to_json
    end
  end

end

