require 'lazy_ncaa'

RSpec.describe LazyNcaa::History do
  describe '.all(round, seed_a, seed_b)' do
    before do
      allow(LazyNcaa::History).to receive(:probs).and_return(probs)
    end

    let(:probs) do
      {
        1 => {
          3 => {
            14 => [4, 3]
          }
        }
      }
    end

    context 'team A is seeded better than team B' do
      it 'returns the wins for each team' do
        expect(described_class.all(1, 3, 14)).to eq([3, 1])
      end
    end

    context 'team A is seeded worse than team B' do
      it 'returns the correct wins for each team' do
        expect(described_class.all(1, 14, 3)).to eq([1, 3])
      end
    end
  end
end
