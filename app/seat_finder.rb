require_relative 'helpers/pretty_matrix'
require_relative 'seat_set'

class SeatFinder
  def initialize(venue)
    @venue = venue
    @availability_matrix = create_availability_matrix(venue)
    @score_matrix = SeatScoreMatrix.new(venue)
    # puts PrettyMatrix.to_s(@availability_matrix) do |seat|
    #   val = seat ? '*' : '-'
    #
    #   val
    # end
  end

  def find_seat_sets(number_of_tickets)
    seat_sets = venue.matrix.flat_map do |row|
      seat_sets_in_row = row.each_cons(number_of_tickets).find_all do |consecutive_seats|
        seats_available = consecutive_seats.all? { |seat| seat.available? }

        seats_available
      end

      seat_sets_in_row.map do |seat_set|
        total_score = seat_set.inject(0) { |accum, seat| accum + score_matrix.score_for(seat) }

        SeatSet.new(seat_set, total_score)
      end unless seat_sets_in_row.empty?
    end.compact

    seat_sets
  end

  private

  attr_reader :venue, :availability_matrix, :score_matrix

  def create_availability_matrix(venue)
    venue.map_seat_matrix do |seat|
      seat.available?
    end
  end
end