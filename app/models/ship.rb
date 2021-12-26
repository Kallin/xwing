# frozen_string_literal: true

class Ship < ApplicationRecord
  has_many :actions, through: :actions_ships
  has_many :factions, through: :factions_ships
end
