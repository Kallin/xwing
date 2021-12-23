# frozen_string_literal: true

module CollectionsHelper
  def ship_count(ship)
    ship_count_for_ship = @ship_counts.find { |ship_count| ship_count.ship_id == ship.id }
    ship_count_for_ship ? ship_count_for_ship.count : 0
  end
end
