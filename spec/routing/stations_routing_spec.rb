require "spec_helper"

describe StationsController do
  describe "routing" do

    it "routes to #new" do
      get("/agroupers/1/stations/new").should route_to("stations#new", :agrouper_id => "1")
    end

  end
end