require_relative 'app/seat_score_matrix'
require_relative 'app/models/venue'

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
    "h7": {
      "id": "h7",
      "row": "h",
      "column": 7,
      "status": "AVAILABLE"
    }
  }
}

class Main
  def initialize(raw_data)
    @raw_data = raw_data
    venue_layout = raw_data[:venue][:layout]
    rows = venue_layout[:rows]
    columns = venue_layout[:columns]
    @scoring_matrix = SeatScoreMatrix.new(rows, columns)

    @venue = Venue.new(rows, columns)

    raw_data[:seats].values.each do |seat_hash|
      venue.mark_seat_as_available(seat_hash[:id])
    end

    puts venue
  end

  def find_best_seat_for(number_of_tickets)
  end

  private

  attr_reader :raw_data, :scoring_matrix, :venue
end


Main.new(input)
