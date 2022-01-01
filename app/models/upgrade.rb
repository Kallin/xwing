# frozen_string_literal: true

class Upgrade < ApplicationRecord
  has_and_belongs_to_many :upgrade_types
end
