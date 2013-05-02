class AddBioToSalons < ActiveRecord::Migration
  def change
    add_column :salons, :bio, :text  
  end
end
