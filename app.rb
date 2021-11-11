require_relative 'app/seat_score_matrix'
require_relative 'app/models/venue'
require_relative 'app/seat_finder'
require 'optparse'
require 'json'

def generate_seats_data
  %w[a1 b5 h7 h8 a25 a24 a6 a7 h48 h49 h50].inject({}) do |memo, seat_key|
    matches = /(\w+)(\d+)/.match(seat_key)

    memo.merge({
      seat_key.to_sym => {
        id: seat_key,
        row: matches[1],
        column: matches[2].to_i,
        status: 'AVAILABLE',
      }
    })
  end
end

input = {
  "venue": {
    "layout": {
      "rows": 10,
      "columns": 50
    }
  },
  "seats": {
  }.merge(generate_seats_data)
}

class Main
  def initialize(raw_data)
    @venue = Venue.from_hash(raw_data)
  end

  def find_best_seat_for(number_of_tickets)
    SeatFinder.new(venue).find_seat_sets(number_of_tickets).sort do |seat_set1, seat_set2|
      seat_set2.score <=> seat_set1.score
    end.first
  end

  private

  attr_reader :raw_data, :scoring_matrix, :venue
end

def options_parser
  @options_parser ||= OptionParser.new do |opts|
    opts.banner = "Usage: #{__FILE__ } [options]"
    opts.on('-iFILE', '--init FILE', String, 'The input file')
    opts.on('-nNUM_SEATS', '--num-seats NUM_SEATS', Integer, 'The number of seats requested')
  end
end

def parse_options
  options = {}
  options_parser.parse!(into: options)
  options.delete(:cibd)

  options
end

options_parser.parse %w[--help] if ARGV.empty?

parsed_options = parse_options

json_input = File.read(parsed_options[:init])
num_seats = parsed_options[:"num-seats"]

main = Main.new(JSON.parse(json_input))

puts main.find_best_seat_for(num_seats)
