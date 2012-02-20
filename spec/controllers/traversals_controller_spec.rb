# encoding: utf-8
require 'spec_helper'

describe TraversalsController do    
  
  def valid_line
    transport = Transport.first || Factory(:metro)
    line = Line.first || Factory(:red_line, :transport_id => transport)
  end
  
  def valid_station(name)
    Factory(name, :line_id => valid_line)
  end
  
  def valid_attributes
    Factory.attributes_for(:traversal).merge(:one_station_id => valid_station(:observatorio).id, :another_station_id => valid_station(:tacubaya).id)
  end

  describe "GET new" do
    
    it "should assign a new traversal" do
      get :new
      assigns(:traversal).should be_a_new(Traversal)
    end
    
  end

  describe "GET index" do
  
    it "should fetch and assign a set of traversals to traversals" do
      traversal = Traversal.create! valid_attributes
      get :index
      assigns(:traversals).should eq([traversal])
    end
  
  end
  
  describe "DELETE destroy" do
    
    before(:each) do
      request.env["HTTP_REFERER"] = traversals_url
    end
    
    it "destroys the requested traversal" do
      traversal = Traversal.create! valid_attributes
      expect {
        delete :destroy, :id => traversal.id.to_s
      }.to change(Traversal, :count).by(-1)
    end

    it "redirects to the traversals list" do
      traversal = Traversal.create! valid_attributes
      delete :destroy, :id => traversal.id.to_s
      response.should redirect_to(traversals_url)
    end
  end
  
  describe "POST create" do
    
    before(:each) do
      @traversal = Traversal.create! valid_attributes
    end
    
    it "creates a new Traversal" do
      expect {
        post :create, :traversal => valid_attributes
      }.to change(Traversal, :count).by(1)
    end
    
    it "should assing a new record to traversal" do      
      post :create, :traversal => valid_attributes
      assigns(:traversal).should be_a(Traversal)
      assigns(:traversal).should be_persisted
    end
    
    describe "on successful save" do
      
      before(:each) do
        @traversal.stub(:save) { true }
      end
      
      it "should respond with a redirect" do
        Traversal.stub(:new) { @traversal }
        post :create, :traversal => {}
        
        response.should redirect_to(traversals_path)
      end
      
    end
    
    describe "on unsuccessful save" do
      before(:each) do
        @traversal.stub(:save) { false }
      end
      
      it "should render a template" do
        Traversal.stub(:new) { @traversal }
        post :create, :traversal => {}
        
        response.should render_template('new')
      end
      
    end
  end
  
  describe "with terminal stations registered" do
  
    before(:each) do
      @ts1=Factory(:station, :name => "Martin Carrera", :line_id => valid_line.id)
      @ts2=Factory(:station, :name => "El Rosario", :line_id => valid_line.id)
    end
  
    describe "POST generate_automatic" do
    
      it "should assign the line and generate the automatic traversals" do
        expect {
          post :generate_automatic, :line_id => valid_line.id
        }.to change(Traversal, :count).by(2)
      end
    
      it "should redirect to the line path" do
        post :generate_automatic, :line_id => valid_line.id
        response.should redirect_to(valid_line)
      end
    
    end
  
    describe "DELETE destroy_automatic" do
    
      before(:each) do
        Factory(:traversal, :one_station_id => @ts1.id, :another_station_id => @ts2.id)
        Factory(:traversal, :one_station_id => @ts2.id, :another_station_id => @ts1.id)
      end
    
      it "should destroy all the automatic generated lines" do
        expect {
          delete :destroy_automatic, :line_id => valid_line.id
        }.to change(Traversal, :count).by(-2)
      end
    
      it "should redirect to the line path" do
        delete :destroy_automatic, :line_id => valid_line.id
        response.should redirect_to(valid_line)
      end
    
    end
  end
end