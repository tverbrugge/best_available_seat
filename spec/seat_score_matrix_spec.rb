require 'rspec'
require_relative '../app/seat_score_matrix'

describe SeatScoreMatrix do
  describe '#score_at' do
    it 'returns a value' do
      score_matrix = described_class.new(2, 3)
      expect(score_matrix.score_at(2, 1)).to eq 0
      expect(score_matrix.score_at(1, 2)).to eq 2
    end
  end
end