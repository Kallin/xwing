class CreateShipTotals < ActiveRecord::Migration[7.0]
  def change
    create_table :ship_totals do |t|
      t.references :ship, null: false, foreign_key: true
      t.references :collection, null: false, foreign_key: true
      t.integer :total

      t.timestamps
    end
  end
end
