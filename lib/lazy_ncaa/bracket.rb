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

    def region
      %w(Midwest West East South)[@index]
    end

    def to_s
      out = ''
      out << "<h2>#{region} Bracket</h2>\n"
      out << "<div class='bracket'>\n"
      (1..4).each do |round|
        out << "<ul class='round round-#{round}'>\n"

        out << "<li class='spacer'>&nbsp;</li>\n"
        @teams[round].each_slice(2) do |top, bottom|
          out << "<li class='game game-top'>#{top}</li>\n"
          out << "<li class='game game-spacer'>&nbsp;</li>\n"
          out << "<li class='game game-bottom'>#{bottom}</li>\n"
          out << "<li class='spacer'>&nbsp;</li>\n"
        end
        out << "</ul>\n"
      end

      out << "<ul class='round round-5'>\n"
      out << "<li class='spacer'>&nbsp;</li>\n"
      out << "<li class='game game-top'>#{@teams[5][0]}</li>\n"
      out << "<li class='spacer'>&nbsp;</li>\n"
      out << "</ul>\n"
      out << "</div>\n"
      out
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
