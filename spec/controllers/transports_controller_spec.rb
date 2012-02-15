# encoding: utf-8
require 'spec_helper'

describe TransportsController do    
  
  def valid_attributes
    Factory.attributes_for(:metro)
  end
  
  describe "GET new" do
    
    it "should assign a new transport" do
      get :new
      assigns(:transport).should be_a_new(Transport)
    end
    
  end
  
  describe "POST create" do
    
    before(:each) do
      @params = {'name' => 'name', 'twitter' => 'tw', 'web_page' => 'page'}
      @transport = Transport.create! valid_attributes
    end
    
    it "should assing a new record to transport" do
      Transport.should_receive(:new).with(@params).and_return(@transport)
      
      post :create, :transport => @params
      assigns(:transport).should == @transport
    end
    
    describe "on successful save" do
      
      before(:each) do
        @transport.stub(:save) { true }
      end
      
      it "should respond with a redirect" do
        Transport.stub(:new) { @transport }
        post :create, :transport => {}
        
        response.should redirect_to(@transport)
      end
      
    end
    
    describe "on unsuccessful save" do
      before(:each) do
        @transport.stub(:save) { false }
      end
      
      it "should render a template" do
        Transport.stub(:new) { @transport }
        post :create, :transport => {}
        
        response.should render_template('new')
      end
      
    end
  end
  
  describe "GET show" do
    
    it "should fetch and assign transport" do
      transport = Transport.create! valid_attributes
      get :show, :id => transport.id
      assigns(:transport).should == transport
    end
    
  end
  
  describe "GET index" do
    
    it "should fetch and assign a set of transports to transports" do
      transport = Transport.create! valid_attributes
      get :index
      assigns(:transports).should eq([transport])
    end
    
  end
  
  describe "GET edit" do
    
    it "should fetch and assign the existing transport" do
      transport = Transport.create! valid_attributes
      get :edit, :id => transport.id
      assigns(:transport).should eq(transport)
    end
  end
  
  describe "PUT update" do
    before(:each) do
      @transport = Transport.create! valid_attributes
    end
    
    it "should fetch and assign the requested record" do
      Transport.should_receive(:find).with("1").and_return(@transport)
      put :update, :id => "1", :transport => {'name' => 'params'}
      assigns(:transport).should == @transport
    end
    
    describe "when successful update" do
      
      before(:each) do
        @transport.stub(:update_attributes) { true }
      end
      
      it "should redirect to show action" do
        Transport.stub(:find) { @transport }
        put :update, :id => "1", :transport => {'name' => 'params'}
        response.should redirect_to(@transport)
      end
      
    end
    
    describe "when unsuccessful update" do
      
      before(:each) do
        @transport.stub(:update_attributes) { false }
      end
      
      it "should render new action" do
        Transport.stub(:find) { @transport }
        put :update, :id => "1", :transport => {'name' => 'params'}
        response.should render_template('edit')
      end
    end
    
    describe "DELETE destroy" do
      it "destroys the requested transport" do
        transport = Transport.create! valid_attributes
        expect {
          delete :destroy, :id => transport.id.to_s
        }.to change(Transport, :count).by(-1)
      end

      it "redirects to the transports list" do
        transport = Transport.create! valid_attributes
        delete :destroy, :id => transport.id.to_s
        response.should redirect_to(transports_url)
      end
    end
    
  end
  
end
