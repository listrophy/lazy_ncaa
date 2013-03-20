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
      "(#{(@seed.to_s)[0..1].rjust(2)}) #{@name[0..9].ljust(10)}"
    end
  end
end
