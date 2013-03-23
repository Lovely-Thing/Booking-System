require 'spec_helper'

describe "wireless_providers/edit" do
  before(:each) do
    @wireless_provider = assign(:wireless_provider, stub_model(WirelessProvider,
      :description => "MyString",
      :domain => "MyString"
    ))
  end

  it "renders the edit wireless_provider form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => wireless_providers_path(@wireless_provider), :method => "post" do
      assert_select "input#wireless_provider_description", :name => "wireless_provider[description]"
      assert_select "input#wireless_provider_domain", :name => "wireless_provider[domain]"
    end
  end
end
