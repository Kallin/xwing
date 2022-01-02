# frozen_string_literal: true

class QuickBuild < ApplicationRecord
  belongs_to :pilot
  has_and_belongs_to_many :upgrades
end
