class SeatAvailabilityMatrix
  def initialize(num_rows, num_columns)
  end

  def mark_seat_available(row, column)
    puts score_matrix.inspect
    score_matrix[row - 1][column - 1]
  end

  private
end