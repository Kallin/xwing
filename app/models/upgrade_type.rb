# frozen_string_literal: true

class UpgradeType < ApplicationRecord
  has_and_belongs_to_many :upgrades
end
