# frozen_string_literal: true

class Ship < ApplicationRecord
  has_and_belongs_to_many :actions
  has_and_belongs_to_many :factions
end
