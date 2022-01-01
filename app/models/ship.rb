# frozen_string_literal: true

class Ship < ApplicationRecord
  has_and_belongs_to_many  :actions
  has_and_belongs_to_many  :factions
  has_many :pilots, dependent: :destroy
end
