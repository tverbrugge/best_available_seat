require_relative 'helpers/matrix_builder'

class SeatScoreMatrix
  def initialize(venue)
    @score_matrix = initialize_matrix(venue.number_of_rows, venue.seats_per_row)
  end

  def score_at(row, seat)
    score_matrix[row - 1][seat - 1]
  end

  def score_for(seat)
    score_matrix[seat.row_number][(seat.seat).to_i - 1]
  end

  private

  def initialize_matrix(num_rows, num_columns)
    center_column = (num_columns / 2)

    MatrixBuilder.build_matrix(num_rows, num_columns) do |row, column|
      column_factor = center_column - ((center_column - column).abs + 1)
      row_factor = num_rows - row

      column_factor + row_factor
    end
  end

  attr_reader :score_matrix
end