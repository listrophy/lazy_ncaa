#!/usr/bin/ruby

TEAMS = [
  'Louisville',
  'Michigan St.',
  'Kansas',
  'Wake Forest',
  'Utah',
  'W Virginia',
  'Boston College',
  'Ohio St.',
  'Siena',
  'S Cal',
  'Dayton',
  'Arizona',
  'Cleve. St',
  'N Dakota St',
  'Robert Morris',
  'Ala St/Morehead',
  'UCONN',
  'Memphis',
  'Missouri',
  'Washington',
  'Purdue',
  'Marquette',
  'California',
  'BYU',
  'Texas A&M',
  'Maryland',
  'Utah St',
  'N Iowa',
  'Miss. St',
  'Cornell',
  'CS Northridge',
  'Chattanooga',
  'Pittsburgh',
  'Duke',
  'Villanova',
  'Xavier',
  'Fla St',
  'UCLA',
  'Texas',
  'Okla St',
  'Tennessee',
  'Minnesota',
  'VCU',
  'Wisconsin',
  'Portland St',
  'American',
  'Binghampton',
  'E Tenn St',
  'N Carolina',
  'Okla',
  'Syracuse',
  'Gonzaga',
  'Illinois',
  'Arizona St',
  'Clemson',
  'LSU',
  'Butler',
  'Michigan',
  'Temple',
  'W Kentucky',
  'Akron',
  'S F Austin',
  'Morgan St',
  'Radford'
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
      1 => {16 => [96, 96]},
      2 => {15 => [96, 92]},
      3 => {14 => [96, 81]},
      4 => {13 => [96, 76]},
      5 => {12 => [96, 65]},
      6 => {11 => [96, 66]},
      7 => {10 => [96, 60]},
      8 => {9 =>  [96, 40]}
    },
    2 => { #round 2
      1 => {
        8 => [44,35],
        9 => [52,49]
      },
      2 => {
        7  => [59,41],
        10 => [33,18]
      },
      3 => {
        6  => [54,29],
        11 => [27,19]
      },
      4 => {
        5  => [52,27],
        12 => [24,14]
      },
      5 => {
        13 => [13,10]
      },
      6 => {
        14 => [12,10]
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
        13 => [7,6]
      }
    },
    3 => {
      1 => {
        4 => [34,25],
        5 => [33,29],
        12 => [15,15],
        13 => [2,2]
      },
      2 => {
        3 => [29,19],
        6 => [23,18],
        11 => [8,7]
      },
      3 => {
        7 => [8,6],
        10 => [11,7]
      },
      4 => {
        8 => [5,2],
        9 => [2,2]
      },
      5 => {
        8 => [2,0],
        9 => [1,0]
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
        2 => [33,17],
        3 => [16,9],
        6 => [8,6],
        7 => [4,4],
        10 => [4,4],
        11 => [4,2]
      },
      2 => {
        4 => [5,2],
        5 => [2,0],
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
        10 => [1,1]
      },
      6 => {
        8 => [1,0]
      },
      7 => {
        8 => [1,0]
      }
    },
    5 => { #final four
      1 => {
        2 => [13,9],
        3 => [6,2],
        4 => [7,5],
        5 => [3,3],
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