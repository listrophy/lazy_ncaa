class Tournament
  def initialize
    @brackets = [
      Bracket.new(0),
      Bracket.new(1),
      Bracket.new(2),
      Bracket.new(3)
    ]
    @final_four = nil
  end
  def play
    @brackets.each do |bracket|
      (1..4).each do |round|
        bracket.play_round
      end
    end
    @final_four = FinalFour.new(@brackets)
    @final_four.play
  end
  def to_s
    @brackets.inject("") {|out,b| "#{out}#{b}"} + @final_four.to_s
  end
end
