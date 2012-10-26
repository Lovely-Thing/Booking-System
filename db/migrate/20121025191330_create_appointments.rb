class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :customer_id
      t.integer :employee_id
      t.datetime :appointment_time
      t.boolean :stylist_confirmed

      t.timestamps
    end
  end
end
