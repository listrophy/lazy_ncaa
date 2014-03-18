module LazyNcaa
  class Team
    def initialize(seed, name = "")
      @seed = seed
      @name = name
    end
    def seed
      @seed
    end
    def to_s
      width = 14
      "(#{(@seed.to_s)[0..1].rjust(2)}) #{@name[0..width].ljust(width+1)}"
    end
  end
end
