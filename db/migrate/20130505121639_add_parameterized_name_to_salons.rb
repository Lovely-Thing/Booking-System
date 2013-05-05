class AddParameterizedNameToSalons < ActiveRecord::Migration
  def self.up
    add_column :salons, :parameterized_name, :string

    salons = Salon.find(:all)
    salons.each do |salon|
    	puts "#{salon.name}  #{salon.name.parameterize}"
    	salon.update_attribute(:parameterized_name, salon.name.parameterize)
    end
    	
  end

  def self.down
  	remove_column :salons, :parameterized_name
  end
end
