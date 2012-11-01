class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_reset_required, :boolean, default: false
    add_column :users, :phone, :string
    add_column :users, :alternate_phone, :string
  end
end
