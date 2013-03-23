class AddWirelessProviderToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :wireless_provider_id, :integer
  end
end
