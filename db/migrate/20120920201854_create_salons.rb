class CreateSalons < ActiveRecord::Migration
  def change
    create_table :salons do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :email
      t.string :url

      t.timestamps
    end
    add_index :salons, [:name]
    add_index :salons, [:city, :state]
    
  end
end
