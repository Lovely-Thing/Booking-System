require 'spec_helper'

describe "stylist_services/edit" do
  before(:each) do
    @stylist_service = assign(:stylist_service, stub_model(StylistService,
      :service_id => 1,
      :employee_id => "MyString",
      :price => 1.5,
      :duration => 1,
      :modified => false
    ))
  end

  it "renders the edit stylist_service form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stylist_services_path(@stylist_service), :method => "post" do
      assert_select "input#stylist_service_service_id", :name => "stylist_service[service_id]"
      assert_select "input#stylist_service_employee_id", :name => "stylist_service[employee_id]"
      assert_select "input#stylist_service_price", :name => "stylist_service[price]"
      assert_select "input#stylist_service_duration", :name => "stylist_service[duration]"
      assert_select "input#stylist_service_modified", :name => "stylist_service[modified]"
    end
  end
end
