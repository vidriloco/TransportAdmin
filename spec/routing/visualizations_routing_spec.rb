require "spec_helper"

describe VisualizationsController do
  describe "routing" do

    it "routes to #index" do
      get("/visualizations").should route_to("visualizations#index")
    end

  end
end