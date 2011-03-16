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