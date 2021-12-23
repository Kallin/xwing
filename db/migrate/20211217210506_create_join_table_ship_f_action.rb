# frozen_string_literal: true

class CreateJoinTableShipFAction < ActiveRecord::Migration[7.0]
  def change
    create_join_table :ships, :factions do |t|
      # t.index [:ship_id, :faction_id]
      # t.index [:faction_id, :ship_id]
    end
  end
end
