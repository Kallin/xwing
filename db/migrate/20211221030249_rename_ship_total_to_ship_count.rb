# frozen_string_literal: true

class RenameShipTotalToShipCount < ActiveRecord::Migration[7.0]
  def change
    rename_table :ship_totals, :ship_counts
    rename_column :ship_counts, :total, :count
  end
end
