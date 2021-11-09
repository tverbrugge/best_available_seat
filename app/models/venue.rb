require_relative 'seat'
require_relative '../helpers/matrix_builder'

class Venue
  def self.from_hash(data_hash)
    venue_layout = data_hash[:venue][:layout]
    rows = venue_layout[:rows]
    columns = venue_layout[:columns]

    venue = new(rows, columns)

    data_hash[:seats].values.each do |seat_hash|
      venue.mark_seat_as_available(seat_hash[:id])
    end

    venue
  end

  def initialize(number_of_rows, seats_per_row)
    @number_of_rows = number_of_rows
    @seats_per_row = seats_per_row
    @matrix = initialize_matrix
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

  def map_seat_matrix
    matrix.map do |row|
      row.map do |seat|
        yield(seat)
      end
    end
  end

  def capacity
    matrix.reduce(0) do |memo, row|
      memo + row.count
    end
  end

  attr_reader :number_of_rows, :seats_per_row, :matrix

  private

  def initialize_matrix
    MatrixBuilder.build_matrix(number_of_rows, seats_per_row) do |row, column|
      row_value = ('a'.ord + row).chr
      column_value = (column + 1).to_s
      Seat.new("#{row_value}#{column_value}", row_value, column_value)
    end
  end
end