module LazyNcaa
  class History
    # PROBS[round][higher_seed][lower_seed] =
    #   [total_matchups, wins_by_higher_seed]
    PROBS = {
      1 => { #round 1
        1 => {16 => [116, 116]},
        2 => {15 => [116, 109]},
        3 => {14 => [116, 99]},
        4 => {13 => [116, 91]},
        5 => {12 => [116, 75]},
        6 => {11 => [116, 77]},
        7 => {10 => [116, 70]},
        8 => {9 =>  [116, 52]}
      },
      2 => { #round 2
        1 => {
          8 => [56,46],
          9 => [60,55]
        },
        2 => {
          7  => [67,49],
          10 => [42,25]
        },
        3 => {
          6  => [63,36],
          11 => [36,24]
        },
        4 => {
          5  => [61,33],
          12 => [30,18]
        },
        5 => {
          13 => [14,11]
        },
        6 => {
          14 => [14,12]
        },
        7 => {
          15 => [3,2]
        },
        10 => {
          15 => [4,4]
        },
        11 => {
          14 => [3,3]
        },
        12 => {
          13 => [11,8]
        }
      },
      3 => {
        1 => {
          4 => [43,30],
          5 => [36,30],
          12 => [19,19],
          13 => [3,3]
        },
        2 => {
          3 => [38,23],
          6 => [27,21],
          11 => [11,10]
        },
        3 => {
          7 => [9,6],
          10 => [13,9],
          15 => [1,1]
        },
        4 => {
          8 => [6,2],
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
        9 => {
          13 => [1,1]
        },
        10 => {
          11 => [1,1],
          14 => [1,1]
        }
      },
      4 => { #round 4
        1 => {
          2 => [39,19],
          3 => [20,12],
          6 => [8,6],
          7 => [4,4],
          10 => [4,4],
          11 => [5,2]
        },
        2 => {
          4 => [6,2],
          5 => [3,0],
          8 => [4,2],
          9 => [1,0],
          12 => [1,1]
        },
        3 => {
          4 => [5,2],
          5 => [3,2],
          8 => [1,1],
          9 => [1,1]
        },
        4 => {
          6 => [3,2],
          7 => [2,2],
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
          2 => [17,12],
          3 => [7,3],
          4 => [9,7],
          5 => [4,4],
          6 => [2,1],
          8 => [2,1],
          9 => [1,1]
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
          4 => [2,2],
          8 => [1,1],
          11 => [1,1]
        },
        4 => {
          5 => [1,1],
          6 => [1,0]
        },
        5 => {
          8 => [1,1]
        },
        8 => {
          11 => [1,1]
        }
      }
    }

    def self.probs
      PROBS
    end

    def self.all(round, seed_a, seed_b)
      games, wins_for_team_a =
        if seed_a < seed_b
          probs[round][seed_a][seed_b]
        else
          probs[round][seed_a][seed_b]
        end

      raise InvalidGameException if games.nil?

      wins_for_team_b = games - wins_for_team_a
      [wins_for_team_a, wins_for_team_b]
    end
  end
end