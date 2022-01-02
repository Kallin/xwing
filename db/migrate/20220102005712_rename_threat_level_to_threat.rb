class RenameThreatLevelToThreat < ActiveRecord::Migration[7.0]
  def change
    rename_column :quick_builds, :threat_level, :threat
  end
end
