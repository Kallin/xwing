# frozen_string_literal: true

class CreateJoinTableShipAction < ActiveRecord::Migration[7.0]
  def change
    create_join_table :ships, :actions do |t|
      # t.index [:ship_id, :action_id]
      # t.index [:action_id, :ship_id]
    end
  end
end
