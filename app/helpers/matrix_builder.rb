class MatrixBuilder
  def self.build_matrix(num_rows, num_columns)
    # Array.new(number_of_rows) { Array.new(seats_per_row, Seat.new) }
    (0...num_rows).map do |row|
      (0...num_columns).map do |column|
        yield(row, column)
      end
    end
  end
end