class AddStylistServiceIdToAppointments < ActiveRecord::Migration
  def change
  	add_column :appointment_services, :stylist_service_id, :integer
  end
end
