class RemoveUpgradeTypeFromUpgrade < ActiveRecord::Migration[7.0]
  def change
    remove_reference :upgrades, :upgrade_type, null: false, foreign_key: true
  end
end
