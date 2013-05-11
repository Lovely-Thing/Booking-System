require 'spec_helper'

describe "stylist_services/index" do
  before(:each) do
    assign(:stylist_services, [
      stub_model(StylistService,
        :service_id => 1,
        :employee_id => "Employee",
        :price => 1.5,
        :duration => 2,
        :modified => false
      ),
      stub_model(StylistService,
        :service_id => 1,
        :employee_id => "Employee",
        :price => 1.5,
        :duration => 2,
        :modified => false
      )
    ])
  end

  it "renders a list of stylist_services" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Employee".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
