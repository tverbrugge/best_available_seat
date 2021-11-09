require_relative 'helpers/pretty_matrix'
require_relative 'seat_score_matrix'
require_relative 'seat_set'
require_relative 'algorithms'

class SeatFinder
  def initialize(venue)
    @venue = venue
    @availability_matrix = create_availability_matrix(venue)
    @score_matrix = SeatScoreMatrix.new(venue)
    # pretty = PrettyMatrix.pretty_print(@availability_matrix) do |seat|
    #   val = seat ? '*' : '-'
    #
    #   val
    # end
    # puts pretty
  end

  def best_seat(number_of_tickets)
    find_seat_sets(number_of_tickets).sort do |seat_set1, seat_set2|
      seat_set2.score <=> seat_set1.score
    end.first
  end

  def find_seat_sets(number_of_tickets)
    row_seat_finder_algorithm = Algorithms::Consecutive.new(number_of_tickets)
    seat_sets = venue.matrix.flat_map do |row|
      seat_sets_in_row = row_seat_finder_algorithm.find_in_row(row)

      create_seat_sets(seat_sets_in_row) unless seat_sets_in_row.empty?
    end.compact

    seat_sets
  end

  private

  def create_seat_sets(seat_sets_in_row)
    seat_sets_in_row.map do |seat_set|
      total_score = seat_set.inject(0) { |accum, seat| accum + score_matrix.score_for(seat) }

      SeatSet.new(seat_set, total_score)
    end
  end

  attr_reader :venue, :availability_matrix, :score_matrix

  def create_availability_matrix(venue)
    venue.map_seat_matrix do |seat|
      seat.available?
    end
  end
end