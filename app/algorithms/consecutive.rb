require_relative 'base'

module Algorithms
  class Consecutive < Base
    def find_in_row(row)
      row.each_cons(number_of_tickets).find_all do |consecutive_seats|
        seats_available = consecutive_seats.all? { |seat| seat.available? }

        seats_available
      end
    end
  end
end