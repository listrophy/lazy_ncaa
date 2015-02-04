require 'lazy_ncaa'

RSpec.describe LazyNcaa::Probability do
  describe '.calculate(round, seed_a, seed_b)' do
    before do
      allow(LazyNcaa::History).to receive(:all).and_return([1, 9])
    end
    let(:probability) { described_class.calculate(1,2,3) }

    it 'returns probability that team A wins' do

      expect(probability).to eq(0.1)
    end
  end

  describe '.ask(round, team_a, team_b)' do
    let(:team_a) { double(:team_a, seed: 1) }
    let(:team_b) { double(:team_b, seed: 2) }

    context 'when seeds are equal' do
      let(:team_b) { double(:team_b, seed: 1) }

      it 'returns 0.5' do
        expect(described_class.ask(5, team_a, team_b)).to eq(0.5)
      end
    end

    context 'round is 6' do
      it 'pretends to be round 5' do
        expect(described_class).to receive(:calculate).with(5, team_a.seed, team_b.seed)

        described_class.ask(6, team_a, team_b)
      end
    end

    context 'non-final game against differently seeded teams' do
      it 'passes arguments directly to .calculate' do
        expect(described_class).to receive(:calculate).with(4, team_a.seed, team_b.seed)

        described_class.ask(4, team_a, team_b)
      end
    end
  end
end
