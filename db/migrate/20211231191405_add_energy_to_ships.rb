class AddEnergyToShips < ActiveRecord::Migration[7.0]
  def change

    add_column(:ships, :energy, :integer)

  end
end
