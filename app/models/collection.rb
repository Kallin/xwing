class Collection < ApplicationRecord
  belongs_to :user
  has_many :ship_totals

  def add_ship(ship)
    ship_total = ship_totals.find_or_create_by(ship: ship)
    ship_total.total += 1
    ship_total.save!
  end

  def total_ship_count
    ship_totals.sum(:total)
  end
end
