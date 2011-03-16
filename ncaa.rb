TEAMS = [
  'Ohio St.',
  'UNC',
  'Syracuse',
  'Kentucky',
  'West VA',
  'Xavier',
  'Washington',
  'George Mason',
  'Villanova',
  'Georgia',
  'Marquette',
  'Play-In 2',
  'Princeton',
  'Indiana St',
  'Long Island',
  'Play-In 1',
  'Duke',
  'San Diego St.',
  'UCONN',
  'Texas',
  'Arizona',
  'Cincinnati',
  'Temple',
  'Michigan',
  'Tennessee',
  'Penn St',
  'Missouri',
  'Memphis',
  'Oakland',
  'Bucknell',
  'N. Colorado',
  'Hampton',
  'Kansas',
  'Notre Dame',
  'Purdue',
  'Louisville',
  'Vanderbilt',
  'Georgetown',
  'Texas A&M',
  'UNLV',
  'Illinois',
  'Florida St',
  'Play-In 3',
  'Richmond',
  'Morehead St',
  'St. Peter\'s',
  'Akron',
  'Boston U',
  'Pittsburgh',
  'Florida',
  'BYU',
  'Wisconsin',
  'Kansas St',
  'St. John\'s',
  'UCLA',
  'Butler',
  'Old Dominion',
  'Michigan St',
  'Gonzaga',
  'Utah St',
  'Belmont',
  'Wofford',
  'UC Santa Barb',
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
