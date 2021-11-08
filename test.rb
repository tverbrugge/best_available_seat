require_relative 'app/seat_score_matrix'
require_relative 'app/models/venue'
require_relative 'app/seat_finder'

def generate_seats_data
  %w[a1 b5 h7 h8 a25 a24 a6 a7 h48 h49 h50].inject({}) do |memo, seat_key|
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

input = {
  "venue": {
    "layout": {
      "rows": 10,
      "columns": 50
    }
  },
  "seats": {
    "a1": {
      "id": "a1",
      "row": "a",
      "column": 1,
      "status": "AVAILABLE"
    },
    "b5": {
      "id": "b5",
      "row": "b",
      "column": 5,
      "status": "AVAILABLE"
    },
  }.merge(generate_seats_data)
}

class Main
  def initialize(raw_data)
    @raw_data = raw_data
    venue_layout = raw_data[:venue][:layout]
    rows = venue_layout[:rows]
    columns = venue_layout[:columns]

    @venue = Venue.new(rows, columns)
    @scoring_matrix = SeatScoreMatrix.new(venue)

    raw_data[:seats].values.each do |seat_hash|
      venue.mark_seat_as_available(seat_hash[:id])
    end

  end

  def find_best_seat_for(number_of_tickets)
    SeatFinder.new(venue).find_seat_sets(number_of_tickets).sort do |seat_set1, seat_set2|
      seat_set2.score <=> seat_set1.score
    end.first
  end

  private

  attr_reader :raw_data, :scoring_matrix, :venue
end

main = Main.new(input)
puts main.find_best_seat_for(2)