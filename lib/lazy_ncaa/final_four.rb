module LazyNcaa
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
      out = ''
      out << "<h2>Final Four</h2>\n"
      out << "<div class='bracket'>\n"

      out << "<ul class='round round-1'>\n"
      out << "<li class='spacer'>&nbsp;</li>\n"

      out << "<li class='game game-top'>#{@team_a}</li>\n"
      out << "<li class='game game-spacer'>&nbsp;</li>\n"
      out << "<li class='game game-bottom'>#{@team_b}</li>\n"

      out << "<li class='spacer'>&nbsp;</li>\n"

      out << "<li class='game game-top'>#{@team_c}</li>\n"
      out << "<li class='game game-spacer'>&nbsp;</li>\n"
      out << "<li class='game game-bottom'>#{@team_d}</li>\n"

      out << "<li class='spacer'>&nbsp;</li>\n"
      out << "</ul>\n"

      out << "<ul class='round round-2'>\n"
      out << "<li class='spacer'>&nbsp;</li>\n"

      out << "<li class='game game-top'>#{@team_ab}</li>\n"
      out << "<li class='game game-spacer'>&nbsp;</li>\n"
      out << "<li class='game game-bottom'>#{@team_cd}</li>\n"

      out << "<li class='spacer'>&nbsp;</li>\n"
      out << "</ul>\n"

      out << "<ul class='round round-3'>\n"
      out << "<li class='spacer'>&nbsp;</li>\n"
      out << "<li class='game game-top'>#{@winner}</li>\n"
      out << "<li class='spacer'>&nbsp;</li>\n"
      out << "</ul>\n"

      out << "</div>\n"

      out
    end

    def to_id
      [@team_ab, @team_cd, @winner].map {|t| t.seed.to_s(16)}.join('')
    end
  end
end
