require_relative 'base'

module Algorithms
  class GrepStyle < Base
    def find_in_row(row)
      seat_sets = []
      pos = number_of_tickets

      while pos < row.length
        # puts "current pos: #{pos}"
        current_slice = row[(pos - number_of_tickets)...pos]
        if all_available?(current_slice)
          seat_sets << current_slice
          pos += 1
        else
          pos += advance_pointer_amount(current_slice)
        end
      end

      seat_sets
    end

    private

    def all_available?(slice)
      slice.all?(&:available?)
    end

    def advance_pointer_amount(slice)
      amount = 0
      slice.reverse_each do |seat|
        # puts "#{seat.to_s} available?: #{seat.available?}"
        break unless seat.available?
        amount += 1
      end

      number_of_tickets - amount
    end

    class RowFinder
      def initialize(row, number_tickets)
        @row = row
        @number_tickets = number_tickets
      end

      def call
        seat_sets = []
        pos = number_tickets

        while (pos < row.length) do
          slice = row[(pos - number_tickets)...number_tickets]
          if all_available?(slice)
            seat_sets << slice
            pos = pos + 1
          else

          end

        end

      end

      private

      attr_reader :row, :number_tickets

      def all_available?(slice)
        slice.all?(&:all_available?)
      end
    end
  end
end