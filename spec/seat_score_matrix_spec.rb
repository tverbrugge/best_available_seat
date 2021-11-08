require 'rspec'
require_relative '../app/seat_score_matrix'
require_relative '../app/models/venue'

describe SeatScoreMatrix do
  describe '#score_at' do
    let(:venue) { Venue.new(2, 3)}
    it 'returns a value' do

      score_matrix = described_class.new(venue)
      expect(score_matrix.score_at(2, 1)).to eq 0
      expect(score_matrix.score_at(1, 2)).to eq 2
      expect(score_matrix.score_at(2, 3)).to eq 0
    end
  end
end