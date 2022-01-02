# frozen_string_literal: true

class Upgrade < ApplicationRecord
  # TODO: support upgrades with the same name (ie R2-D2)
  has_and_belongs_to_many :upgrade_types
end
