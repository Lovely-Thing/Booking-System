class CreateAppointmentHistories < ActiveRecord::Migration
  def change
    create_table :appointment_histories do |t|
      t.integer :appointment_id
      t.integer :customer_id
      t.integer :employee_id
      t.datetime :appointment_time
      t.integer :state
      t.string :note

      t.timestamps
    end
  end
end
