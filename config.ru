require 'sass/plugin/rack'
require './go_fish_app'

#logger = Logger.new("sinatra.log")
#use Rack::CommonLogger, logger
@logger = Rack::Logger.new(@app)

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

run GoFishApp
