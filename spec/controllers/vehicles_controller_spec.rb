# encoding: utf-8
require 'spec_helper'

describe VehiclesController do
  
  def valid_attributes
    transport = Factory(:metro)
    line = Factory(:red_line, :transport_id => transport.id)
    {:identifier => "OP", :line_id => line.id}
  end
  
  describe "GET new" do
    
    it "should assign a new vehicle" do
      get :new
      assigns(:vehicle).should be_a_new(Vehicle)
    end
    
  end
  
  describe "POST create" do
    
    before(:each) do
      @vehicle = Vehicle.stub! valid_attributes
    end
    
    it "creates a new Vehicle" do
      expect {
        post :create, :vehicle => valid_attributes
      }.to change(Vehicle, :count).by(1)
    end
    
    it "should assing a new record to vehicle" do      
      post :create, :vehicle => valid_attributes
      assigns(:vehicle).should be_a(Vehicle)
      assigns(:vehicle).should be_persisted
    end
    
    describe "on successful save" do
      
      before(:each) do
        @vehicle.stub(:save) { true }
      end
      
      it "should respond with a redirect" do
        Vehicle.stub(:new) { @vehicle }
        post :create, :vehicle => {}
        
        response.should redirect_to(vehicles_url)
      end
      
    end
    
    describe "on unsuccessful save" do
      before(:each) do
        @vehicle.stub(:save) { false }
      end
      
      it "should render a template" do
        Vehicle.stub(:new) { @vehicle }
        post :create, :vehicle => {}
        
        response.should render_template('new')
      end
      
    end
  end
  
  describe "GET index" do
    
    it "should fetch and assign a set of vehicles to vehicles" do
      vehicle = Vehicle.create! valid_attributes
      get :index
      assigns(:vehicles).should eq([vehicle])
    end
  end
  
  describe "GET edit" do
    
    it "should fetch and assign the existing vehicle" do
      vehicle = Vehicle.create! valid_attributes
      get :edit, :id => vehicle.id
      assigns(:vehicle).should eq(vehicle)
    end
  end
  
  describe "PUT update" do
    before(:each) do
      @vehicle = Vehicle.create! valid_attributes
    end
    
    it "should fetch and assign the requested record" do
      put :update, :id => @vehicle.id, :vehicle => valid_attributes
      assigns(:vehicle).should == @vehicle
    end
    
    describe "when successful update" do
      
      before(:each) do
        @vehicle.stub(:update_attributes) { true }
      end
      
      it "should redirect to show action" do
        Vehicle.stub(:find) { @vehicle }
        put :update, :id => "1", :vehicle => valid_attributes
        response.should redirect_to(vehicles_path)
      end
      
    end
    
    describe "when unsuccessful update" do
      
      before(:each) do
        @vehicle.stub(:update_attributes) { false }
      end
      
      it "should render new action" do
        Vehicle.stub(:find) { @vehicle }
        put :update, :id => "1", :vehicle => {'name' => 'params'}
        response.should render_template('edit')
      end
    end
    
    describe "DELETE destroy" do
      it "destroys the requested vehicle" do
        expect {
          delete :destroy, :id => @vehicle.id.to_s
        }.to change(Vehicle, :count).by(-1)
      end

      it "redirects to the vehicles list" do
        delete :destroy, :id => @vehicle.id.to_s
        response.should redirect_to(vehicles_url)
      end
    end
    
  end
end