class AddImageToSalons < ActiveRecord::Migration
  def change
    add_column :salons, :image, :string
  end
end
