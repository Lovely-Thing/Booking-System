class AddStiColsToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :alternate_phone, :string

    add_column :users, :salon_id, :integer
    add_column :users, :type, :string
  end
end
