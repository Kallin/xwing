class CreateUpgrades < ActiveRecord::Migration[7.0]
  def change
    create_table :upgrades do |t|
      t.string :name
      t.integer :threat_level
      t.references :upgrade_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
