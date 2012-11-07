class RemoveStylistConfirmedFromAppointments < ActiveRecord::Migration
  def up
  	remove_column :appointments, :stylist_confirmed
  end

  def down
  	add_column :appointments, :stylist_confirmed, :boolean, :default => 0
  end
end
