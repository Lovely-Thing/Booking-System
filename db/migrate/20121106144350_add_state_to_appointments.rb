class AddStateToAppointments < ActiveRecord::Migration
  def change
  	add_column :appointments, :state, :integer
  end
end
