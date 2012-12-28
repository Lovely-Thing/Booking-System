class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :description
      t.float :price
      t.integer :duration

      t.timestamps
    end
  end
end
