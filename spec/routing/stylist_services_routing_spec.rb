require "spec_helper"

describe StylistServicesController do
  describe "routing" do

    it "routes to #index" do
      get("/stylist_services").should route_to("stylist_services#index")
    end

    it "routes to #new" do
      get("/stylist_services/new").should route_to("stylist_services#new")
    end

    it "routes to #show" do
      get("/stylist_services/1").should route_to("stylist_services#show", :id => "1")
    end

    it "routes to #edit" do
      get("/stylist_services/1/edit").should route_to("stylist_services#edit", :id => "1")
    end

    it "routes to #create" do
      post("/stylist_services").should route_to("stylist_services#create")
    end

    it "routes to #update" do
      put("/stylist_services/1").should route_to("stylist_services#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/stylist_services/1").should route_to("stylist_services#destroy", :id => "1")
    end

  end
end
