require 'rspec'
require_relative '../../app/models/venue'

describe Venue do
  describe '#initialize' do
  end

  describe '#mark_seat_as_available' do
  end

  describe '#capacity' do
    it 'returns the capacity' do
      expect(described_class.new(1, 1).capacity).to eq 1
      expect(described_class.new(3, 2).capacity).to eq 6
      expect(described_class.new(7, 4).capacity).to eq 28
    end
  end

  describe '#find_seat' do
    it 'finds the correct seat' do
      venue = described_class.new(1, 1)

      expect(venue.find_seat('a1').id).to eq 'a1'
    end

    it 'returns nil if the seat does not exist' do
      venue = described_class.new(1, 1)

      expect(venue.find_seat('blorg')).to be_nil
    end
  end
end