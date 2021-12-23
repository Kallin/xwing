module CollectionsHelper
  def ship_count(ship)
    ship_count = @ship_counts.find { |ship_count| ship_count.ship_id == ship.id }
    ship_count ? ship_count.count : 0
  end
end
