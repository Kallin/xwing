class RemoveThreatLevelFromUpgrade < ActiveRecord::Migration[7.0]
  def change
    remove_column :upgrades, :threat_level, :integer
  end
end
