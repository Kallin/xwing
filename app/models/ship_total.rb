class ShipTotal < ApplicationRecord
  belongs_to :collection
  belongs_to :ship

  attribute :total, default: 0
end
