class SeatScoreMatrix
  def initialize(num_rows, num_columns)
    @num_rows = num_rows
    @num_columns = num_columns

    @score_matrix = initialize_matrix(num_rows, num_columns)
  end

  def score_at(row, column)
    score_matrix[row - 1][column - 1]
  end

  private

  def initialize_matrix(num_rows, num_columns)
    center_column = (num_columns / 2) + 1
    (1..num_rows).map do |row|
      (1..num_columns).map do |column|
        column_factor = center_column - ((center_column - column).abs + 1)
        row_factor = num_rows - row

        column_factor + row_factor
      end
    end
  end

  attr_reader :score_matrix
end