require 'spec_helper'

describe "wireless_providers/index" do
  before(:each) do
    assign(:wireless_providers, [
      stub_model(WirelessProvider,
        :description => "Description",
        :domain => "Domain"
      ),
      stub_model(WirelessProvider,
        :description => "Description",
        :domain => "Domain"
      )
    ])
  end

  it "renders a list of wireless_providers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Domain".to_s, :count => 2
  end
end
