require 'spec_helper'

describe "services/new" do
  before(:each) do
    assign(:service, stub_model(Service,
      :name => "MyString",
      :description => "MyString",
      :price => 1.5,
      :duration => 1
    ).as_new_record)
  end

  it "renders new service form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => services_path, :method => "post" do
      assert_select "input#service_name", :name => "service[name]"
      assert_select "input#service_description", :name => "service[description]"
      assert_select "input#service_price", :name => "service[price]"
      assert_select "input#service_duration", :name => "service[duration]"
    end
  end
end
