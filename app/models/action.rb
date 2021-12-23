# frozen_string_literal: true

class Action < ApplicationRecord
  has_and_belongs_to_many :ships
end
