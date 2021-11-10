require_relative '../spec_helper'

describe Algorithms::GrepStyle do
  def create_row
    generate_seats(1, 120) do |_, column|
      yield(column) ? Seat::AVAILABLE : Seat::SOLD
    end.first
  end

  describe '#find_in_row' do
    it 'returns empty if the number of requested seats is greater than the row capacity' do
      row = generate_seats(1, 2).first

      expect(described_class.new(5).find_in_row(row)).to eq([])
    end

    it 'returns a set when all matches' do
      row = create_row { |column| (3...8).include?(column) }

      expect(described_class.new(5).find_in_row(row).count).to eq(1)
      expect(described_class.new(5).find_in_row(row).first.map(&:seat)).to eq(%w[4 5 6 7 8])
    end

    it 'returns all seat sets that match' do
      row = create_row { |column| (3...8).include?(column) || (10...15).include?(column) }

      expect(described_class.new(5).find_in_row(row).count).to eq(2)
    end

    it 'returns all seats that match even if the set is directly adjacent' do
      row = create_row { |column| (3...8).include?(column) || (4...9).include?(column) }

      expect(described_class.new(5).find_in_row(row).count).to eq(2)
    end
  end
end