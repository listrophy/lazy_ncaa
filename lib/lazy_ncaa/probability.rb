module LazyNcaa
  class Probability
    class << self
      # return probability that seed_a will win
      def ask(round, team_a, team_b)
        seed_a, seed_b = team_a.seed, team_b.seed
        if seed_a == seed_b
          0.5
        else
          round = 5 if round == 6
          calculate(round, seed_a, seed_b)
        end
      end

      def calculate(round, seed_a, seed_b)
        wins_for_team_a, wins_for_team_b = History.all(round, seed_a, seed_b)
        games = wins_for_team_a + wins_for_team_b

        1.0 * wins_for_team_a / games
      end
    end
  end
end
