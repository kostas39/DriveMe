class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :brand
      t.string :model
      t.string :color
      t.string :location
      t.string :engine_size
      t.references :user, null: false, foreign_key: true
      t.string :plate

      t.timestamps
    end
  end
end
