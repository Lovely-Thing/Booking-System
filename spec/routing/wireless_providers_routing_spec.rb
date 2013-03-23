require "spec_helper"

describe WirelessProvidersController do
  describe "routing" do

    it "routes to #index" do
      get("/wireless_providers").should route_to("wireless_providers#index")
    end

    it "routes to #new" do
      get("/wireless_providers/new").should route_to("wireless_providers#new")
    end

    it "routes to #show" do
      get("/wireless_providers/1").should route_to("wireless_providers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/wireless_providers/1/edit").should route_to("wireless_providers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/wireless_providers").should route_to("wireless_providers#create")
    end

    it "routes to #update" do
      put("/wireless_providers/1").should route_to("wireless_providers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/wireless_providers/1").should route_to("wireless_providers#destroy", :id => "1")
    end

  end
end
