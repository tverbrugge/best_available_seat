class PrettyMatrix
  def self.pretty_print(matrix)
    matrix.map do |row|
      row.map do |seat|
        if block_given?
          yield seat
        else
          seat.inspect
        end
      end.join(', ')
    end.join("\n")
  end
end