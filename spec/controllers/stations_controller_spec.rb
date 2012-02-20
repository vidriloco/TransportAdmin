# encoding: utf-8
require 'spec_helper'

describe StationsController do

  before(:each) do
    @agrouper = Factory(:red_line, :transport_id => Factory(:metro).id)
    @agrouper_params = {:agrouper_id => @agrouper.id, :agrouper_type => @agrouper.class.to_s}
  end
  
  describe "GET new" do
    it "assigns a new station as @station" do
      get :new, @agrouper_params
      assigns(:station).should be_a_new(Station)
    end
  
    it "assigns the requested agrouper as @agrouper" do
      get :new, @agrouper_params
      assigns(:agrouper).should == @agrouper
    end
  end
  
  describe "POST create" do
        
    describe "with valid arguments" do
      
      before(:each) do
        @valid_attrs = Factory.attributes_for(:station).merge(@agrouper_params)
        @coordinates = {:lat => 19.3424, :lon => -99.140496}
      end
      
      it "creates a new Station" do
        expect {
          post :create, :station => @valid_attrs, :coordinates => @coordinates
        }.to change(Station, :count).by(1)
      end

      it "assigns a newly created station as @station" do
        post :create, :station => @valid_attrs, :coordinates => @coordinates
        assigns(:agrouper).should be_a(Line)
        assigns(:station).should be_a(Station)
        assigns(:station).should be_persisted
      end

      it "redirects to the agroupers list" do
        post :create, :station => @valid_attrs, :coordinates => @coordinates
        response.should redirect_to(@agrouper)
      end
      
    end
    
    describe "with invalid arguments" do
      it "assigns a newly created but unsaved station as @station" do
        Station.any_instance.stub(:save).and_return(false)
        post :create, :station => @agrouper_params
        assigns(:agrouper).should be_a(Line)
        assigns(:station).should be_a_new(Station)
      end

      it "re-renders the 'new' template" do
        Station.any_instance.stub(:save).and_return(false)
        post :create, :station => @agrouper_params
        response.should render_template("new")
      end
    end
    
    describe "DELETE destroy" do
      
      before(:each) do
        @station = Factory(:station, @agrouper_params)
      end
      
      it "destroys the requested station" do
        expect {
          delete :destroy, :id => @station.id.to_s
        }.to change(Station, :count).by(-1)
      end

      it "redirects to the line show" do
        delete :destroy, :id => @station.id.to_s
        response.should redirect_to(line_path(@agrouper))
      end
    end
    
    describe "GET edit" do
      
      before(:each) do
        @station = Factory(:station, @agrouper_params)
      end
      
      it "assigns the requested station as @station" do
        station = @station
        get :edit, :id => station.id.to_s
        assigns(:station).should eq(station)
        assigns(:agrouper).should be_a(Line)
      end
    end
    
    describe "PUT update" do
      
      before(:each) do
        @station = Factory(:station, @agrouper_params)
      end
      
      describe "with valid params" do
        
        before(:each) do
          @coordinates = {:lat => 19.3424, :lon => -99.140496}
        end
        
        it "updates the requested station" do
          Station.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => @station.id, :station => {'these' => 'params'}
        end

        it "assigns the requested station as @station" do
          put :update, :id => @station.id, :station => @agrouper_params, :coordinates => @coordinates
          assigns(:station).should eq(@station)
        end

        it "redirects to the station agrouper" do
          put :update, :id => @station.id, :station => @agrouper_params, :coordinates => @coordinates
          response.should redirect_to(@station.agrouper)
        end
      end

      describe "with invalid params" do
        it "assigns the station as @station" do
          Station.any_instance.stub(:save).and_return(false)
          put :update, :id => @station.id.to_s, :station => {}
          assigns(:station).should eq(@station)
        end

        it "re-renders the 'edit' template" do
          Station.any_instance.stub(:save).and_return(false)
          put :update, :id => @station.id.to_s, :station => {}
          response.should render_template("edit")
        end
      end
    end
    
    
  end

end