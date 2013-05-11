class CreateStylistServices < ActiveRecord::Migration
  def self.up
    create_table :stylist_services do |t|
      t.integer :service_id
      t.string :employee_id
      t.float :price
      t.integer :duration
      t.boolean :modified

      t.timestamps
    end

    # populate with all the services for all employees
    salons = Salon.find(:all)
    salons.each do |salon|
      salon.employees.each do |employee|
        salon.services.each do |service|
          ss = StylistService.new(service_id: service.id,
            employee_id: employee.id,
            price: service.price,
            duration: service.duration,
            modified: false)
          ss.save!
        end
      end
    end

  end


  def self.down
    drop_table :stylist_services
  end
end
