require 'rspec'
require_relative '../app/algorithms'
require_relative '../app/models/seat'
require_relative '../app/helpers/matrix_builder'

def generate_seats(row, columns)
  MatrixBuilder.build_matrix(row, columns) do |row, column|
    row_value = ('a'.ord + row).chr
    column_value = (column + 1).to_s

    seat_status = Seat::SOLD

    if block_given?
      seat_status = yield(row, column) || Seat::SOLD
    end

    Seat.new("#{row_value}#{column_value}", row_value, column_value, seat_status)
  end
end