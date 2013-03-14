class AddHoursToSalons < ActiveRecord::Migration
  def change
    add_column :salons, :sunday_hours, :string
    add_column :salons, :monday_hours, :string
    add_column :salons, :tuesday_hours, :string
    add_column :salons, :wednesday_hours, :string
    add_column :salons, :thursday_hours, :string
    add_column :salons, :friday_hours, :string
    add_column :salons, :saturday_hours, :string
  end
end
