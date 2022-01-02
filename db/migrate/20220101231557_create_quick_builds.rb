class CreateQuickBuilds < ActiveRecord::Migration[7.0]
  def change
    create_table :quick_builds do |t|
      t.references :pilot, null: false, foreign_key: true
      t.integer :threat_level

      t.timestamps
    end
  end
end
