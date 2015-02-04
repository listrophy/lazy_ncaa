require 'lazy_ncaa'

RSpec.describe LazyNcaa::Matchup do
  describe '#winner' do
    before do
      allow(LazyNcaa::Probability).to receive(:ask).and_return(0.8)
      allow(Kernel).to receive(:rand).and_return(0.5)
    end

    let(:matchup) { described_class.new(1, 'a', 'b') }

    it 'chooses the right winner' do
      expect(matchup.winner).to eq('a')
    end
  end
end
