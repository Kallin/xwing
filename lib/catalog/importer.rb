# frozen_string_literal: true

require_relative 'reader'
require_relative 'translator'

module Catalog
  class Importer
    attr_accessor :input_ships, :input_actions, :input_factions

    def import_all
      import_factions
      import_actions

      @input_ships.each do |input_ship|
        input_ship[:factions] = input_ship[:factions].map do |faction|
          Faction.find_by(name: faction)
        end
      end

      import_ships
    end

    def delete_all
      [Faction, Action, Ship].each(&:destroy_all)
    end

    def set_inputs_from_loader
      loader = Catalog::Loader.new
      loader.collect_entities_from_input_files

      translator = Catalog::Translator.new
      translator.input_pilots = loader.input_pilots
      translator.input_actions = loader.input_actions
      translator.input_factions = loader.input_factions

      translator.translate_all

      @input_actions = translator.actions
      @input_factions = translator.factions
      @input_ships = translator.ships
    end

    def refresh_all
      delete_all
      set_inputs_from_loader
      import_all
    end

    private

    def import_ships
      Ship.create!(input_ships)
    end

    def import_actions
      Action.create!(input_actions)
    end

    def import_factions
      Faction.create!(input_factions)
    end
  end
end
