class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer :user_id
      t.integer :salon_id
      t.boolean :salon_admin

      t.timestamps
    end
  end
end
