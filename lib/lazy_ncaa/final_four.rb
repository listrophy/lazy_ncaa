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
