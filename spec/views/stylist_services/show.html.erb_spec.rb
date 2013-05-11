require 'spec_helper'

describe "stylist_services/show" do
  before(:each) do
    @stylist_service = assign(:stylist_service, stub_model(StylistService,
      :service_id => 1,
      :employee_id => "Employee",
      :price => 1.5,
      :duration => 2,
      :modified => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Employee/)
    rendered.should match(/1.5/)
    rendered.should match(/2/)
    rendered.should match(/false/)
  end
end
