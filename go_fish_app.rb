require 'sinatra/base'
require 'slim'
require 'pry'
require_relative './go_fish_game'

class LoginScreen < Sinatra::Base
  enable :sessions

  get('/login') { slim :login }

  post('/login') do
    session['user_name'] = params[:name]
    game = GoFishGame.new(2)
    game.setup_game
    session['game_id'] = game.object_id
    GoFishApp.games[game.object_id] = game
    redirect '/'
  end
end

class GoFishApp < Sinatra::Base
  @@games = {}
  def self.games
    @@games
  end
  # middleware will run before filters
  use LoginScreen
  
  configure :production, :development do
    enable :logging
  end
  

  before do
    unless session['user_name']
      redirect '/login'
     #halt "Access denied, please <a href='/login'>login</a>."
    end
  end

  get '/' do
    @user_name = session['user_name']
    @game = @@games[session['game_id']]
    slim :hand
  end

  
end

