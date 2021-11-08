class SeatSet
  def initialize(seats, score)
    @seats = seats
    @score = score
  end

  attr_reader :seats, :score

  def to_s
    "#{seats.map(&:to_s).to_s} - score: #{score}"
  end
end