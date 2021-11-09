require 'rspec'
require_relative '../app/seat_finder'
require_relative '../app/models/venue'

describe SeatFinder do

  def generate_seats_data(available_seats)
    available_seats.inject({}) do |memo, seat_key|
      matches = /(\w+)(\d+)/.match(seat_key)

      memo.merge({
        seat_key.to_sym => {
          id: seat_key,
          row: matches[1],
          column: matches[2].to_i,
          status: 'AVAILABLE',
        }
      })
    end
  end

  def create_sample_data(rows, columns, available_seats)
    {
      venue: {
        layout: {
          rows: rows,
          columns: columns
        }
      },
      seats: generate_seats_data(available_seats)
    }
  end

  def create_venue(rows, columns, available_seats)
    Venue.from_hash(create_sample_data(rows, columns, available_seats))
  end

  it 'returns the only available set when only 1 is present' do
    venue = create_venue(20, 50, %w[a1 a2 b4 b6 b8 b10 b12])

    found_seat_sets = described_class.new(venue).find_seat_sets(2)

    expect(found_seat_sets.count).to eq 1
    expect(found_seat_sets.first.seats.map(&:id)).to eq %w[a1 a2]
  end

  it 'returns all available sets' do
    venue = create_venue(20, 50, %w[a1 a2 b3 b4 d22 d23 j23 j24 a25 a26])

    found_seat_sets = described_class.new(venue).find_seat_sets(2)

    expect(found_seat_sets.count).to eq 5
  end

  it 'returns available sets even when they overlap' do
    venue = create_venue(20, 50, %w[a1 a2 a3 a4])

    found_seat_sets = described_class.new(venue).find_seat_sets(2)

    expect(found_seat_sets.count).to eq 3

    expect(found_seat_sets.find { |seat_set| seat_set.seats.map(&:id) == %w[a1 a2] }).to_not be_nil
    expect(found_seat_sets.find { |seat_set| seat_set.seats.map(&:id) == %w[a2 a3] }).to_not be_nil
    expect(found_seat_sets.find { |seat_set| seat_set.seats.map(&:id) == %w[a3 a4] }).to_not be_nil
  end

  it 'returns a scoring favoring middle front' do
    venue = create_venue(2, 3, %w[a2 b1])

    found_seat_sets = described_class.new(venue).find_seat_sets(1)

    expect(found_seat_sets.count).to eq 2
    seat_set_middle_front = found_seat_sets.find { |seat_set| seat_set.seats.map(&:id) == %w[a2] }
    back_corner = found_seat_sets.find { |seat_set| seat_set.seats.map(&:id) == %w[b1] }

    expect(seat_set_middle_front.score).to be > back_corner.score
  end

  describe '#best_seat' do
    it 'returns the best seat available in the house' do
      venue = create_venue(25, 300, %w[b1 b2 b3 a149 a150 a151])

      expect(
        described_class.new(venue).best_seat(3).seats.map(&:id)
      ).to eq(%w[a149 a150 a151])
    end
  end
end