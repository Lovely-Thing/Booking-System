class AddNoteToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :note, :string
  end
end
