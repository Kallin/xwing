# frozen_string_literal: true

module Catalog
  class Importer
    attr_accessor :input_ships, :input_actions, :input_factions

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
