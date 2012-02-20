# encoding: utf-8
require 'spec_helper'

describe DockingStationsController do
  
  def attributes_for_transport
    Factory.attributes_for(:ecobici)
  end
  
  def valid_attributes
    Factory.attributes_for(:docking_station).merge(:transport_id => Transport.create(attributes_for_transport).id)
  end
  
  describe "GET new" do
    it "assigns a new docking_station as @docking_station together with it's transport" do
      DockingStation.create! valid_attributes
      get :new, {:transport_id => 1}
      assigns(:docking_station).should be_a_new(DockingStation)
    end
  end
  
  describe "POST create" do    
        
    describe "with valid arguments" do
      
      before(:each) do
        @coordinates = {:lat => 19.3424, :lon => -99.140496}
      end
      
      it "creates a new docking station" do
        expect {
          post :create, :docking_station => valid_attributes, :coordinates => @coordinates
        }.to change(DockingStation, :count).by(1)
      end

      it "assigns a newly created docking station as @docking_station" do
        post :create, :docking_station => valid_attributes, :coordinates => @coordinates
        assigns(:docking_station).should be_a(DockingStation)
        assigns(:docking_station).should be_persisted
      end

      it "redirects to the transports list" do
        post :create, :docking_station => valid_attributes, :coordinates => @coordinates
        response.should redirect_to(DockingStation.last.transport)
      end
      
    end
    
    describe "with invalid arguments" do
      it "assigns a newly created but unsaved docking station as @docking_station" do
        DockingStation.any_instance.stub(:save).and_return(false)
        post :create, :docking_station => {}, :coordinates => {}
        assigns(:docking_station).should be_a_new(DockingStation)
      end

      it "re-renders the 'new' template" do
        DockingStation.any_instance.stub(:save).and_return(false)
        post :create, :docking_station => {}, :coordinates => {}
        response.should render_template("new")
      end
    end
  end
  
  describe "DELETE destroy" do
    it "destroys the requested docking station" do
      docking_station = DockingStation.create! valid_attributes
      expect {
        delete :destroy, :id => docking_station.id.to_s
      }.to change(DockingStation, :count).by(-1)
    end

    it "redirects to the lines list" do
      docking_station = DockingStation.create! valid_attributes
      delete :destroy, :id => docking_station.id.to_s
      response.should redirect_to(transport_url(docking_station.transport))
    end
  end
  
end