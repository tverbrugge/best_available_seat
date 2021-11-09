module Algorithms
  class Base
    def initialize(number_of_tickets)
      @number_of_tickets = number_of_tickets
    end

    attr_reader :number_of_tickets

    def find_in_row(row)
      throw NotImplementedError
    end
  end
end