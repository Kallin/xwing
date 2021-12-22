class CollectionsController < ApplicationController

  before_action :authenticate_user!

  def show
    @collection = current_user.collection || current_user.create_collection
    @ship_counts = @collection.ship_counts.to_a

    @ships = Ship.all
  end

  def add_ship
    ship = Ship.find(params[:ship_id])
    @collection = current_user.collection
    @collection.add_ship(ship)
    @ship_counts = @collection.ship_counts.to_a

    @ships = Ship.all
    render 'show'
  end

  def remove_ship
    ship = Ship.find(params[:ship_id])
    @collection = current_user.collection
    @collection.remove_ship(ship)
    @ship_counts = @collection.ship_counts.to_a

    @ships = Ship.all
    render 'show'
  end


end
