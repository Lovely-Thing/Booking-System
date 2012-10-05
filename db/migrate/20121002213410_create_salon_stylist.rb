class CreateSalonStylist < ActiveRecord::Migration
  def change
    create_table :salon_stylists do |t|
      t.integer :user_id
      t.integer :salon_id
      t.integer :salon_admin

      t.timestamps
    end
  end
end
