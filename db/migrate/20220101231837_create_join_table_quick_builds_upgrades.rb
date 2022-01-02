class CreateJoinTableQuickBuildsUpgrades < ActiveRecord::Migration[7.0]
  def change
    create_join_table :quick_builds, :upgrades do |t|
      # t.index [:quick_build_id, :upgrade_id]
      # t.index [:upgrade_id, :quick_build_id]
    end
  end
end
