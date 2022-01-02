# frozen_string_literal: true

require_relative 'reader'
require_relative 'translator'
require_relative 'upgrade_types'

# rubocop:disable Metrics/ClassLength:
module Catalog
  class Importer
    attr_accessor :input_ships, :input_actions, :input_factions, :input_pilots, :input_upgrade_types, :input_upgrades,
                  :input_quick_builds

    def refresh_all
      delete_all
      setup_manual_inputs
      setup_inputs_from_loader
      import_all
    end

    def import_all
      import_upgrade_types
      setup_and_import_upgrades
      import_factions
      import_actions
      setup_and_import_ships
      setup_and_import_pilots
      setup_and_import_quick_builds
    end

    private

    def setup_and_import_quick_builds
      @input_quick_builds.each do |input_quick_build|
        input_quick_build[:upgrades] = input_quick_build[:upgrades].map do |upgrade|
          Upgrade.find_by(xws_id: upgrade)
        end
        input_quick_build[:pilot] = Pilot.find_by(xws_id: input_quick_build[:pilot])
      end
      import_quick_builds
    end

    def import_quick_builds
      QuickBuild.create!(input_quick_builds)
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

    def import_upgrades
      Upgrade.create!(input_upgrades)
    end

    def setup_and_import_upgrades
      @input_upgrades.each do |input_upgrade|
        input_upgrade[:upgrade_types] = UpgradeType.where(name: input_upgrade[:upgrade_types])
      end
      import_upgrades
    end

    def delete_all
      [Faction, Action, Ship, UpgradeType, Upgrade, Pilot].each(&:destroy_all)
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
      @input_upgrades = translator.upgrades
      @input_quick_builds = translator.quick_builds
    end

    def run_translator(reader)
      translator = Catalog::Translator.new
      translator.input_pilots = reader.input_pilots
      translator.input_actions = reader.input_actions
      translator.input_factions = reader.input_factions
      translator.input_upgrades = reader.input_upgrades
      translator.input_quick_builds = reader.input_quick_builds

      translator.translate_all
      translator
    end

    def run_loader
      loader = Catalog::Reader.new
      loader.collect_entities_from_input_files
      loader
    end

    def setup_upgrade_types
      @input_upgrade_types = UpgradeTypes.all_upgrade_types
    end

    def setup_manual_inputs
      setup_upgrade_types
    end

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
# rubocop:enable Metrics/ClassLength:
