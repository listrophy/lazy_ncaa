require 'yaml'

module LazyNcaa
  class History

    def self.probs
      YAML::load_file(File.expand_path('../history.yml', __FILE__))
    end

    def self.all(round, seed_a, seed_b)
      games, wins_for_team_a =
        if seed_a < seed_b
          probs[round][seed_a][seed_b]
        else
          games, wins_for_team_b = probs[round][seed_b][seed_a]
          [games, (games - wins_for_team_b)]
        end

      raise InvalidGameException if games.nil?

      wins_for_team_b = games - wins_for_team_a
      [wins_for_team_a, wins_for_team_b]
    end
  end
end
