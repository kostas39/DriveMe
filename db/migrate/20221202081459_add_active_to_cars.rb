class AddActiveToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :active, :boolean, default: true
  end
end
