class AddCreatedByToAppointmentHistories < ActiveRecord::Migration
  def change
    add_column :appointment_histories, :created_by, :integer
  end
end
