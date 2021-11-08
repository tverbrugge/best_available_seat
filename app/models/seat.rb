class Seat
  STATUSES = [
    SOLD = 'SOLD',
    AVAILABLE = 'AVAILABLE'
  ]

  def initialize(id, row, seat, initial_status = SOLD)
    @status = initial_status
    @id = id
    @row = row
    @seat = seat
  end

  def available?
    status == AVAILABLE
  end

  def mark_available
    @status = AVAILABLE
  end

  def row_number
    row.ord - 'a'.ord
  end

  def to_s
    "#{id} - #{status}"
  end

  attr_reader :status, :id, :row, :seat

end