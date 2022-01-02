class AddXwsIdToUpgrades < ActiveRecord::Migration[7.0]
  def change
    add_column :upgrades, :xws_id, :string
  end
end
