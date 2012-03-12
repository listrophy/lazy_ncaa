TEAMS = [
  'Kentucky',
  'Duke',
  'Baylor',
  'Indiana',
  'Wichita St',
  'UNLV',
  'Notre Dame',
  'Iowa St',
  'UCONN',
  'Xavier',
  'Colorado',
  'VCU',
  'New Mexico St',
  'S Dakota St',
  'Lehigh',
  'Play-In 1',

  'Michigan St',
  'Nissouri',
  'Marquette',
  'Louisville',
  'New Mexico',
  'Murray St',
  'Florida',
  'Memphis',
  'St Louis',
  'Virginia',
  'Colorado St',
  'Long Beach St',
  'Davidson',
  'Play-In 2',
  'Norfolk St',
  'Long Island',

  'Syracuse',
  'Ohio St',
  'Flordia St',
  'Wisconsin',
  'Vanderbilt',
  'Cincinnati',
  'Gonazaga',
  'Kansas St',
  'So Mississippi',
  'W Virginia',
  'Texas',
  'Harvard',
  'Montana',
  'St Bonaventure',
  'Loyola (MD)',
  'UNC Asheville',

  'UNC',
  'Kansas',
  'Georgetown',
  'Michigan',
  'Temple',
  'San Diego St',
  'St Mary\'s',
  'Creighton',
  'Alabama',
  'Purdue',
  'N Carolina St',
  'Play-In 3',
  'Ohio',
  'Belmont',
  'Detroit',
  'Play-In 4'
]

require File.expand_path('../lib/lazy_ncaa', __FILE__)

def generate_tournament
  ok = false
  bad_tournaments = 0
  tournament = nil
  while not ok
    begin
      tournament = Tournament.new
      tournament.play
      ok = true
    rescue InvalidGameException
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
