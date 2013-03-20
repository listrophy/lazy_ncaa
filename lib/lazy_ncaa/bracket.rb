module LazyNcaa
  class Bracket
    def initialize(index)
      @index = index
      @round = 1
      @teams = []
      @teams[1] = []
      [1,8,5,4,6,3,7,2].each_with_index do |s, i|
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
    end

    def to_id
      @teams.drop(2).map do |round|
        round.map do |winner|
          winner.seed.to_s(16)
        end.join('')
      end.join('')
    end

  end
end
