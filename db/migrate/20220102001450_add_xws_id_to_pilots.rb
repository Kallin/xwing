class AddXwsIdToPilots < ActiveRecord::Migration[7.0]
  def change
    add_column :pilots, :xws_id, :string
  end
end
