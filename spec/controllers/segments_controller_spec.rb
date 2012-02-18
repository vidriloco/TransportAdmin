# encoding: utf-8
require 'spec_helper'

describe SegmentsController do

  before(:each) do
    @line = Factory(:red_line, :transport_id => Factory(:metro).id)
    @line_params = {:line_id => @line.id}
  end
  
  describe "GET new" do        
    it "assigns a new station as @station" do
      get :new, @line_params
      assigns(:segment).should be_a_new(Segment)
    end
  
    it "assigns the requested line as @line" do
      get :new, @line_params
      assigns(:line).should == @line
    end
  end
  
  describe "with valid parameters" do
    
    before(:each) do
      @valid_parameters = @line_params.merge({
        :origin_station_id => Factory(:observatorio, :agrouper => @line).id, 
        :destination_station_id => Factory(:tacubaya, :agrouper => @line).id, 
        :line_id => @line.id,
        :double_direction => true
      })
    end
    
    describe "POST create" do
      describe "with valid params" do
      
        it "creates a new Segment" do
          expect {
            post :create, :segment => @valid_parameters
          }.to change(Segment, :count).by(1)
        end

        it "assigns a newly created segment as @segment" do
          post :create, :segment => @valid_parameters
          assigns(:segment).should be_a(Segment)
          assigns(:segment).should be_persisted
          assigns(:line).should be_a(Line)
        end

        it "redirects to the created segment" do
          post :create, :segment => @valid_parameters
          response.should redirect_to(@line)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved segment as @segment" do
          Segment.any_instance.stub(:save).and_return(false)
          post :create, :segment => {:line_id => @line.id}
          assigns(:segment).should be_a_new(Segment)
          assigns(:line).should be_a(Line)
        end

        it "re-renders the 'new' template" do
          Segment.any_instance.stub(:save).and_return(false)
          post :create, :segment => {}
          response.should render_template("new")
        end
      end
    end
  
    describe "DELETE destroy" do
    
      it "destroys the requested segment" do
        segment = Segment.create! @valid_parameters
        expect {
          delete :destroy, :id => segment.id.to_s
        }.to change(Segment, :count).by(-1)
      end

      it "redirects to the lines segment" do
        segment = Segment.create! @valid_parameters
        delete :destroy, :id => segment.id.to_s
        response.should redirect_to(@line)
      end
    end
  
    describe "GET edit" do
      it "assigns the requested segment as @segment" do
        segment = Segment.create! @valid_parameters
        get :edit, :id => segment.id.to_s
        assigns(:segment).should eq(segment)
        assigns(:line).should be_a(Line)
      end
    end
    
    
    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested segment" do
          segment = Segment.create! @valid_parameters

          Segment.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => segment.id, :segment => {'these' => 'params'}
        end

        it "assigns the requested segment as @segment" do
          segment = Segment.create! @valid_parameters
          put :update, :id => segment.id, :segment => @valid_parameters
          assigns(:segment).should eq(segment)
          assigns(:line).should be_a(Line)
        end

        it "redirects to the segment" do
          segment = Segment.create! @valid_parameters
          put :update, :id => segment.id, :segment => @valid_parameters
          response.should redirect_to(@line)
        end
      end

      describe "with invalid params" do
        it "assigns the segment as @segment" do
          segment = Segment.create! @valid_parameters
          Segment.any_instance.stub(:save).and_return(false)
          put :update, :id => segment.id.to_s, :segment => {}
          assigns(:segment).should eq(segment)
        end

        it "re-renders the 'edit' template" do
          segment = Segment.create! @valid_parameters
          Segment.any_instance.stub(:save).and_return(false)
          put :update, :id => segment.id.to_s, :segment => {}
          response.should render_template("edit")
        end
      end
    end
    
  end
  
end