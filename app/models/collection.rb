class Collection < ApplicationRecord
  belongs_to :user
  has_many :ship_counts

  def add_ship(ship)
    ship_count = ship_counts.find_or_create_by(ship: ship)
    ship_count.count += 1
    ship_count.save!
  end

  def remove_ship(ship)
    ship_count = ship_counts.find_or_create_by(ship: ship)
    ship_count.count -= 1 unless ship_count.count == 0
    ship_count.save!
  end

  def total_ship_count
    ship_counts.sum(:count)
  end
end
