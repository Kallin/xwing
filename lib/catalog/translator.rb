# frozen_string_literal: true

module Catalog
  class Translator
    attr_accessor :input_pilots, :input_factions, :input_actions, :input_upgrades, :input_quick_builds,
                  :ships, :pilots, :factions, :actions, :upgrades, :quick_builds

    def translate_pilots
      @ships = []
      @pilots = []
      @input_pilots.each { |input_pilot| extract_ship_and_pilots(input_pilot) }
    end

    def translate_actions
      @actions = input_actions.map { |input_action| { name: input_action['name'] } }
    end

    def translate_factions
      @factions = input_factions.map { |input_faction| { name: input_faction['name'] } }
    end

    def translate_upgrades
      @upgrades = input_upgrades.map do |input_upgrade|
        { name: input_upgrade['name'], xws_id: input_upgrade['xws'], upgrade_types: input_upgrade['sides'][0]['slots'] }
      end
    end

    def translate_quick_builds
      @quick_builds = input_quick_builds.map do |input_quick_build|
        pilot = input_quick_build['pilots'][0]
        upgrades = []
        upgrades = pilot['upgrades'].values.flatten unless pilot['upgrades'].nil?
        { threat: input_quick_build['threat'], pilot: pilot['id'], upgrades: }
      end
    end

    def extract_ship_and_pilots(input_ship)
      extract_ship(input_ship)
      extract_pilots(input_ship)
    end

    def extract_pilots(input_ship)
      input_ship['pilots'].each do |actual_input_pilot|
        @pilots << {
          name: actual_input_pilot['name'],
          ship: input_ship['name'],
          xws_id: actual_input_pilot['xws']
        }
      end
    end

    def extract_ship(input_ship)
      existing_ship = @ships.find { |ship| ship[:name] == input_ship['name'] }
      if existing_ship
        existing_ship[:factions] << input_ship['faction']
      else
        @ships << build_ship(input_ship)
      end
    end

    def build_ship(input_ship)
      {
        name: input_ship['name'],
        factions: [input_ship['faction']],
        agility: find_stat(input_ship, 'agility'),
        hull: find_stat(input_ship, 'hull'),
        shields: find_stat(input_ship, 'shields'),
        energy: find_stat(input_ship, 'energy'),
        attack: find_stat(input_ship, 'attack')
      }
    end

    def find_stat(input_ship, stat_name)
      stat = input_ship['stats'].find { |it| it['type'] == stat_name }
      stat ? stat['value'] : 0
    end

    def translate_all
      translate_pilots
      translate_actions
      translate_factions
      translate_upgrades
      translate_quick_builds
    end
  end
end
