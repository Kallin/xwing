class ShipCount < ApplicationRecord
  belongs_to :collection
  belongs_to :ship

  attribute :count, default: 0
end
