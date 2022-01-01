# frozen_string_literal: true

require_relative 'reader'
require_relative 'translator'
require_relative 'upgrade_types'

module Catalog
  class Importer
    attr_accessor :input_ships, :input_actions, :input_factions, :input_pilots, :input_upgrade_types

    def import_all
      import_upgrade_types
      import_factions
      import_actions
      setup_and_import_ships
      setup_and_import_pilots
    end

    def setup_and_import_ships
      @input_ships.each do |input_ship|
        input_ship[:factions] = input_ship[:factions].map do |faction|
          Faction.find_by(name: faction)
        end
      end
      import_ships
    end

    def setup_and_import_pilots
      @input_pilots.each do |input_pilot|
        input_pilot[:ship] = Ship.find_by(name: input_pilot[:ship])
      end
      import_pilots
    end

    def delete_all
      [Faction, Action, Ship, UpgradeType, Pilot].each(&:destroy_all)
    end

    def setup_inputs_from_loader
      loader = run_loader
      translator = run_translator(loader)
      setup_inputs(translator)
    end

    def setup_inputs(translator)
      @input_actions = translator.actions
      @input_factions = translator.factions
      @input_ships = translator.ships
      @input_pilots = translator.pilots
    end

    def run_translator(loader)
      translator = Catalog::Translator.new
      translator.input_pilots = loader.input_pilots
      translator.input_actions = loader.input_actions
      translator.input_factions = loader.input_factions

      translator.translate_all
      translator
    end

    def run_loader
      loader = Catalog::Loader.new
      loader.collect_entities_from_input_files
      loader
    end

    def setup_upgrade_types
      @input_upgrade_types = UpgradeTypes.all_upgrade_types
    end

    def setup_manual_inputs
      setup_upgrade_types
    end

    def refresh_all
      delete_all
      setup_manual_inputs
      setup_inputs_from_loader
      import_all
    end

    private

    def import_upgrade_types
      UpgradeType.create!(input_upgrade_types)
    end

    def import_pilots
      Pilot.create!(input_pilots)
    end

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
