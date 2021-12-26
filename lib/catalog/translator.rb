# frozen_string_literal: true

module Catalog
  class Translator
    attr_accessor :input_pilots, :ships, :pilots

    def translate_pilots
      @ships = []
      @pilots = []
      @input_pilots.each { |input_pilot| extract_ships_and_pilots(input_pilot) }
    end

    def extract_ships_and_pilots(input_ship)
      extract_ships(input_ship)
      extract_pilots(input_ship)
    end

    def extract_pilots(input_ship)
      input_ship['pilots'].each do |actual_input_pilot|
        @pilots << {
          name: actual_input_pilot['name'],
          ship: input_ship['name']
        }
      end
    end

    def extract_ships(input_ship)
      @ships << {
        name: input_ship['name'],
        faction: input_ship['faction'],
        agility: find_stat(input_ship, 'agility'),
        hull: find_stat(input_ship, 'hull'),
        shields: find_stat(input_ship, 'shields'),
        energy: find_stat(input_ship, 'energy')
      }
    end

    def find_stat(input_ship, stat_name)
      stat = input_ship['stats'].find { |it| it['type'] == stat_name }
      stat ? stat['value'] : 0
    end
  end
end
