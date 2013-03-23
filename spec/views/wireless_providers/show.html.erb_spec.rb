require 'spec_helper'

describe "wireless_providers/show" do
  before(:each) do
    @wireless_provider = assign(:wireless_provider, stub_model(WirelessProvider,
      :description => "Description",
      :domain => "Domain"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
    rendered.should match(/Domain/)
  end
end
