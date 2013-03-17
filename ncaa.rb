TEAMS = [
  'Louisville',
  'Duke',
  'Michigan St',
  'St Louis',
  'Okla St',
  'Memphis',
  'Creighton',
  'Colorado St',
  'Missouri',
  'Cincinnati',
  'Play-in MW 1',
  'Oregon',
  'New Mex St',
  'Valparaiso',
  'Albany',
  'Play-In MW 2',

  'Gonzaga',
  'Ohio St',
  'New Mexico',
  'Kansas St',
  'Wisconsin',
  'Arizona',
  'Notre Dame',
  'Pittsburgh',
  'Wichita St',
  'Iowa St',
  'Belmont',
  'Ole Miss',
  'Play-In W',
  'Harvard',
  'Iona',
  'Southern U',

  'Kansas',
  'Georgetown',
  'Florida',
  'Michigan',
  'VCU',
  'UCLA',
  'San Diego St',
  'N Carolina',
  'Villanova',
  'Oklahoma',
  'Minnesota',
  'Akron',
  'S Dakota St',
  'Nwestern St',
  'FGCU',
  'Western Ky',

  'Indiana',
  'Miami (Fl)',
  'Marquette',
  'Syracuse',
  'UNLV',
  'Butler',
  'Illinois',
  'NC State',
  'Temple',
  'Colorado',
  'Bucknell',
  'California',
  'Montana',
  'Davidson',
  'Pacific',
  'Play-In E'
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

get '/2012' do
  @tournament = generate_tournament
  haml :index
end
