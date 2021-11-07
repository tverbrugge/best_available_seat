require 'rspec'
require_relative '../../app/models/seat'

describe Seat do
  describe '#initialize' do
    it 'the default state is SOLD' do
      expect(described_class.new('id', 'a', '1').status).to eq described_class::SOLD
    end
  end

  describe '#available?' do
    it 'returns false if the status of the seat is not AVAILABLE' do
      seat = described_class.new('id', 'a', '1')
      expect(seat.available?).to eq false
    end

    it 'returns true if the status of the seat is AVAILABLE' do
      seat = described_class.new('id', 'a', '1', described_class::AVAILABLE)

      expect(seat.available?).to eq true
    end
  end

  describe '#mark_available' do
    it 'sets the status of the seat to AVAILABLE' do
      seat = described_class.new('id', 'a', '1')

      expect(seat.available?).to eq false

      seat.mark_available

      expect(seat.available?).to eq true
    end
  end
end