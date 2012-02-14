# encoding: utf-8
require 'spec_helper'

describe TransportsController do    
  
  describe "GET new" do
    
    before(:each) do
      @transport = Transport.new
    end
    
    it "should assign a new transport" do
      Transport.should_receive(:new).and_return(@transport)
      get :new
      assigns(:transport).should == @transport
    end
    
  end
  
  describe "POST create" do
    
    before(:each) do
      @params = {'name' => 'name', 'twitter' => 'tw', 'web_page' => 'page'}
      @transport = Transport.create(@params)
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
    
    before(:each) do
      @transport = Factory.stub(:metro)
    end
    
    it "should fetch and assign transport" do
      Transport.should_receive(:find).with("1").and_return(@transport)
      get :show, :id => "1"
      assigns(:transport).should == @transport
    end
    
  end
  
  describe "GET index" do
    before(:each) do
      @transports = [Factory.stub(:metro)]
    end
    
    it "should fetch and assign a set of transports to transports" do
      Transport.should_receive(:all).and_return(@transports)
      get :index
      assigns(:transports).should == @transports
    end
  end
  
  describe "GET edit" do
    before(:each) do
      @transport = Factory.stub(:metro)
    end
    
    it "should fetch and assign the existing transport" do
      Transport.should_receive(:find).with("1").and_return(@transport)
      get :edit, :id => "1"
      assigns(:transport).should == @transport
    end
  end
  
  describe "PUT update" do
    before(:each) do
      @transport = Factory(:metro)
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
    
  end
  
end
