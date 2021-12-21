class CollectionsController < ApplicationController

  before_action :authenticate_user!

  def show
    @collection = current_user.collection || current_user.create_collection

    @ships = Ship.all
  end

  def add_ship
    ship = Ship.find(params[:ship_id])
    current_user.collection.add_ship(ship)

    @ships = Ship.all
    render 'show'
  end

  def remove_ship
    puts 'we be working to remove!'
  end


end
