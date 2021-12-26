# frozen_string_literal: true

class Action < ApplicationRecord
  has_many :ships, through: :actions_ships
end
