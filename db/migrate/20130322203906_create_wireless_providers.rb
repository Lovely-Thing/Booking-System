class CreateWirelessProviders < ActiveRecord::Migration
  def change
    create_table :wireless_providers do |t|
      t.string :description
      t.string :domain

      t.timestamps
    end
  end
end
