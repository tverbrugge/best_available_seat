require_relative 'seat'

class Venue
  def initialize(number_of_rows, seats_per_row)
    @number_of_rows = number_of_rows
    @seats_per_row = seats_per_row
    @matrix = initialize_matrix(number_of_rows, seats_per_row)
  end

  def mark_seat_as_available(seat_id)
    find_seat(seat_id).mark_available
  end

  def find_seat(seat_id)
    matrix.each do |row|
      row.each do |seat|
        return seat if seat.id == seat_id
      end
    end

    nil
  end

  def create_availability_matrix
    score_matrix = SeatScoreMatrix.new(number_of_rows, seats_per_row)
    matrix.map.with_index do |row, rowIdx|
      row.map.with_index do |seat, seatIdx|
      end
    end
  end

  def capacity
    matrix.reduce(0) do |memo, row|
      memo + row.count
    end
  end

  private

  attr_reader :matrix, :number_of_rows, :seats_per_row

  def initialize_matrix(number_of_rows, seats_per_row)
    # Array.new(number_of_rows) { Array.new(seats_per_row, Seat.new) }
    (0...number_of_rows).map do |row|
      (0...seats_per_row).map do |column|
        row_value = ('a'.ord + row).chr
        column_value = (column + 1).to_s
        Seat.new("#{row_value}#{column_value}", row_value, column_value)
      end
    end
  end
end