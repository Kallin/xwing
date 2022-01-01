class CreateJoinTableUpgradesUpgradeTypes < ActiveRecord::Migration[7.0]
  def change
    create_join_table :upgrades, :upgrade_types do |t|
      # t.index [:upgrade_id, :upgrade_type_id]
      # t.index [:upgrade_type_id, :upgrade_id]
    end
  end
end
