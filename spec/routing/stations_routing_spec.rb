require "spec_helper"

describe StationsController do
  describe "routing" do

    it "routes lines to #new" do
      get("/lines/1/stations/new").should route_to("stations#new", :agrouper_id => "1", :agrouper_type => "Line")
    end

  end
end