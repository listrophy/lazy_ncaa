#!/usr/bin/ruby

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

class Team
  def initialize(seed, name = "")
    @seed = seed
    @name = name
  end
  def seed
    @seed
  end
  def to_s
    "(#{(@seed.to_s)[0..1].rjust(2)}) #{@name[0..9].ljust(10)}"
  end
end
class Matchup
  def initialize(round, team_a, team_b)
    @round = round
    @team_a = team_a
    @team_b = team_b
  end
  def winner
    probability = Probability.ask(@round, @team_a.seed, @team_b.seed)
    result = rand
    if result < probability
      @team_a
    else
      @team_b
    end
  end
  def to_s
    "#{@team_a}\n#{@team_b}\n"
  end
end
class Bracket
  def initialize(index)
    @index = index
    @round = 1
    @teams = []
    @teams[1] = []
    [1,8,5,4,3,6,7,2].each_with_index do |s, i|
      other = 17 - s
      @teams[@round].push Team.new(s,TEAMS[index*16 + s-1])
      @teams[@round].push Team.new(other,TEAMS[index*16 + other-1])
    end
  end
  def play_round
    round = @teams[@round].clone
    @teams[@round+1] = []
    while round.size > 0
      m = Matchup.new(@round, round.shift, round.shift)
      # print m
      @teams[@round+1].push m.winner
    end
    @round += 1
  end
  def winner
    @teams[5][0]
  end
  def to_s
    %Q{
BRACKET #{@index+1}
#{@teams[1][0] }
#{@teams[1][1] } #{@teams[2][0]}
#{@teams[1][2] } #{@teams[2][1]}
#{@teams[1][3] }                 #{@teams[3][0]}
#{@teams[1][4] }                 #{@teams[3][1]}
#{@teams[1][5] } #{@teams[2][2]}
#{@teams[1][6] } #{@teams[2][3]}
#{@teams[1][7] }                               #{@teams[4][0]}
                                                           #{@teams[5][0]}
#{@teams[1][8] }                               #{@teams[4][1]}
#{@teams[1][9] } #{@teams[2][4]}
#{@teams[1][10]} #{@teams[2][5]}
#{@teams[1][11]}                 #{@teams[3][2]}
#{@teams[1][12]}                 #{@teams[3][3]}
#{@teams[1][13]} #{@teams[2][6]}
#{@teams[1][14]} #{@teams[2][7]}
#{@teams[1][15]}
}
    # "#{@teams}\n"
    # @teams.inject("BRACKET #{@index}\n") {|out, m| "#{out}#{m}\n"}
  end
end
class FinalFour
  def initialize(brackets)
    @team_a = brackets[0].winner
    @team_b = brackets[1].winner
    @team_c = brackets[2].winner
    @team_d = brackets[3].winner
  end
  def play
    @team_ab = Matchup.new(5, @team_a, @team_b).winner
    @team_cd = Matchup.new(5, @team_c, @team_d).winner
    @winner  = Matchup.new(6, @team_ab, @team_cd).winner
  end
  def to_s
    %Q{

FINAL FOUR
#{@team_a }
#{@team_b } #{@team_ab}
                                  #{@winner}
#{@team_c } #{@team_cd}
#{@team_d }
}
  end
end
class Tournament
  def initialize
    @brackets = [
      Bracket.new(0),
      Bracket.new(1),
      Bracket.new(2),
      Bracket.new(3)
    ]
    @final_four = nil
  end
  def play
    @brackets.each do |bracket|
      (1..4).each do |round|
        bracket.play_round
      end
    end
    @final_four = FinalFour.new(@brackets)
    @final_four.play
  end
  def to_s
    @brackets.inject("") {|out,b| "#{out}#{b}"} + @final_four.to_s
  end
end
class Probability
  PROBS = {
    1 => { #round 1
      1 => {16 => [104, 104]},
      2 => {15 => [104, 100]},
      3 => {14 => [104, 88]},
      4 => {13 => [104, 82]},
      5 => {12 => [104, 69]},
      6 => {11 => [104, 71]},
      7 => {10 => [104, 62]},
      8 => {9 =>  [104, 44]}
    },
    2 => { #round 2
      1 => {
        8 => [48,39],
        9 => [56,52]
      },
      2 => {
        7  => [61,43],
        10 => [39,23]
      },
      3 => {
        6  => [58,32],
        11 => [30,21]
      },
      4 => {
        5  => [55,28],
        12 => [27,16]
      },
      5 => {
        13 => [14,11]
      },
      6 => {
        14 => [13,11]
      },
      7 => {
        15 => [1,1]
      },
      10 => {
        15 => [3,3]
      },
      11 => {
        14 => [3,3]
      },
      12 => {
        13 => [8,7]
      }
    },
    3 => {
      1 => {
        4 => [37,28],
        5 => [35,30],
        12 => [17,17],
        13 => [2,2]
      },
      2 => {
        3 => [33,21],
        6 => [25,19],
        11 => [9,8]
      },
      3 => {
        7 => [8,6],
        10 => [12,8]
      },
      4 => {
        8 => [5,2],
        9 => [2,2]
      },
      5 => {
        8 => [2,0],
        9 => [2,1]
      },
      6 => {
        7 => [6,3],
        10 => [6,4]
      },
      7 => {
        11 => [3,0],
        14 => [1,1]
      },
      8 => {
        12 => [1,0],
        13 => [1,1]
      },
      10 => {
        14 => [1,1]
      }
    },
    4 => { #round 4
      1 => {
        2 => [36,18],
        3 => [19,11],
        6 => [8,6],
        7 => [4,4],
        10 => [4,4],
        11 => [4,2]
      },
      2 => {
        4 => [5,2],
        5 => [3,0],
        8 => [3,2],
        12 => [1,1]
      },
      3 => {
        4 => [3,2],
        5 => [2,1],
        8 => [1,1],
        9 => [1,1]
      },
      4 => {
        6 => [3,2],
        7 => [1,1],
        10 => [2,2]
      },
      5 => {
        6 => [1, 1],
        10 => [1,1]
      },
      6 => {
        8 => [1,0]
      },
      7 => {
        8 => [1,0]
      }
    },
    5 => { #all of final four
      1 => {
        2 => [16,11],
        3 => [7,3],
        4 => [7,5],
        5 => [4,4],
        6 => [2,1],
        8 => [2,1]
      },
      2 => {
        3 => [10,6],
        4 => [1,1],
        5 => [1,0],
        6 => [2,1],
        8 => [1,0],
        11 => [1,1]
      },
      3 => {
        4 => [1,1],
        11 => [1,1]
      },
      4 => {
        5 => [1,1],
        6 => [1,0]
      },
      5 => {
        8 => [1,1]
      }
    }
  }
  # return probability that seed_a will win
  def self.ask(round, seed_a, seed_b)
    if seed_a == seed_b
      0.5
    else
      round = 5 if round == 6
      if seed_a < seed_b
        gw = PROBS[round][seed_a][seed_b]
        raise InvalidGameException if gw.nil?
        games = gw[0]
        wins = gw[1]
        1.0 * wins / games
      else
        gl = PROBS[round][seed_b][seed_a]
        raise InvalidGameException if gl.nil?
        games = gl[0]
        losses = gl[1]
        1.0 * (games - losses) / games
      end
    end
  end
end

class InvalidGameException < RuntimeError; end

ok = false
bad_tournaments = 0
while not ok
  begin
    tournament = Tournament.new
    tournament.play
    ok = true
    print "#{tournament}\n"
  rescue InvalidGameException
    bad_tournaments += 1
    # print "invalid game!\n"
  end
end
print "Bad Tournaments: #{bad_tournaments}\n"
