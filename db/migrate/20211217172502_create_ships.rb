# frozen_string_literal: true

class CreateShips < ActiveRecord::Migration[7.0]
  def change
    create_table :ships do |t|
      t.string :name
      t.integer :attack
      t.integer :hull
      t.integer :shields
      t.integer :agility

      t.timestamps
    end
  end
end
