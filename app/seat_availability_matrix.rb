class SeatAvailabilityMatrix
  def initialize(venue)
  end


  def create_availability_matrix(venue)
    venue.map_seat_matrix do |seat|
      seat.available?
    end
  end
end