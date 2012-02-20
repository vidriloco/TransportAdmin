# encoding: utf-8
require 'spec_helper'

describe StationsController do

  before(:each) do
    @line = Factory(:red_line, :transport_id => Factory(:metro).id)
    @line_params = {:line_id => @line.id}
  end
  
  describe "GET new" do
    it "assigns a new station as @station" do
      get :new, @line_params
      assigns(:station).should be_a_new(Station)
      assigns(:line).should be_a(Line)
    end
  end
  
  describe "POST create" do
        
    describe "with valid arguments" do
      
      before(:each) do
        @valid_attrs = Factory.attributes_for(:station).merge(@line_params)
        @coordinates = {:lat => 19.3424, :lon => -99.140496}
      end
      
      it "creates a new Station" do
        expect {
          post :create, :station => @valid_attrs, :coordinates => @coordinates
        }.to change(Station, :count).by(1)
      end

      it "assigns a newly created station as @station" do
        post :create, :station => @valid_attrs, :coordinates => @coordinates
        assigns(:line).should be_a(Line)
        assigns(:station).should be_a(Station)
        assigns(:station).should be_persisted
      end

      it "redirects to the lines list" do
        post :create, :station => @valid_attrs, :coordinates => @coordinates
        response.should redirect_to(@line)
      end
      
    end
    
    describe "with invalid arguments" do
      it "assigns a newly created but unsaved station as @station" do
        Station.any_instance.stub(:save).and_return(false)
        post :create, :station => @line_params
        assigns(:line).should be_a(Line)
        assigns(:station).should be_a_new(Station)
      end

      it "re-renders the 'new' template" do
        Station.any_instance.stub(:save).and_return(false)
        post :create, :station => @line_params
        response.should render_template("new")
      end
    end
    
    describe "DELETE destroy" do
      
      before(:each) do
        @station = Factory(:station, @line_params)
      end
      
      it "destroys the requested station" do
        expect {
          delete :destroy, :id => @station.id.to_s
        }.to change(Station, :count).by(-1)
      end

      it "redirects to the line show" do
        delete :destroy, :id => @station.id.to_s
        response.should redirect_to(line_path(@line))
      end
    end
    
    describe "GET edit" do
      
      before(:each) do
        @station = Factory(:station, @line_params)
      end
      
      it "assigns the requested station as @station" do
        station = @station
        get :edit, :id => station.id.to_s, :line_id => @line.id
        assigns(:station).should eq(station)
        assigns(:line).should be_a(Line)
      end
    end
    
    describe "PUT update" do
      
      before(:each) do
        @station = Factory(:station, @line_params)
      end
      
      describe "with valid params" do
        
        before(:each) do
          @coordinates = {:lat => 19.3424, :lon => -99.140496}
        end
        
        it "updates the requested station" do
          Station.any_instance.should_receive(:update_attributes).with("line_id" => @line.id.to_s)
          put :update, :id => @station.id, :station => {"line_id" => @line.id}
        end

        it "assigns the requested station as @station" do
          put :update, :id => @station.id, :station => @line_params, :coordinates => @coordinates
          assigns(:station).should eq(@station)
        end

        it "redirects to the station line" do
          put :update, :id => @station.id, :station => @line_params, :coordinates => @coordinates
          response.should redirect_to(@station.line)
        end
      end

      describe "with invalid params" do
        it "assigns the station as @station" do
          Station.any_instance.stub(:save).and_return(false)
          put :update, :id => @station.id.to_s, :station => @line_params
          assigns(:station).should eq(@station)
        end

        it "re-renders the 'edit' template" do
          Station.any_instance.stub(:save).and_return(false)
          put :update, :id => @station.id.to_s, :station => @line_params
          response.should render_template("edit")
        end
      end
    end
    
    
  end

end