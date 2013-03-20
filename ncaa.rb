require File.expand_path('../teams', __FILE__)
require File.expand_path('../lib/lazy_ncaa', __FILE__)
require 'base64'

def generate_tournament
  ok = false
  bad_tournaments = 0
  tournament = nil
  while not ok
    begin
      tournament = LazyNcaa::Tournament.new
      tournament.play
      ok = true
    rescue LazyNcaa::InvalidGameException
      bad_tournaments += 1
      # print "invalid game!\n"
    rescue NoMethodError => e
      # (shrug)
    end
  end
  tournament
end

require 'bundler'
Bundler.require :default
require 'sinatra'
require 'haml'

get '/' do
  @tournament = generate_tournament
  haml :index
end

get '/2012' do
  @tournament = generate_tournament
  haml :index
end
