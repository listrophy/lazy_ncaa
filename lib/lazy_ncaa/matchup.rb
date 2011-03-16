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
