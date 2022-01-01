class CreatePilots < ActiveRecord::Migration[7.0]
  def change
    create_table :pilots do |t|
      t.string :name
      t.references :ship, null: false, foreign_key: true
      t.integer :initiative
      t.boolean :limited

      t.timestamps
    end
  end
end
