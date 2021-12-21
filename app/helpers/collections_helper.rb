module CollectionsHelper

  def ship_count(ship)
    ship_count = current_user.collection.ship_counts.find_by_ship_id(ship.id)
    ship_count ? ship_count.count : 0
  end

end
