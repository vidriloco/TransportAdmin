# encoding: utf-8
require 'spec_helper'

describe WaysController do
  
  def valid_attributes
    Factory.attributes_for(:way, :line_id => Factory(:red_line, :transport_id => Factory(:metro)))
  end
    
  describe "POST create" do
    describe "with valid params" do
      
      before(:each) do
        @line = Factory(:red_line, :transport_id => Factory(:metro).id)
      end
      
      it "creates a new Way associated with a Line" do
        expect {
          post :create, :line_id => @line.id, :way => valid_attributes
        }.to change(Way, :count).by(1)
      end

      it "assigns a newly created way as @way" do
        post :create, :line_id => @line.id, :way => valid_attributes
        assigns(:way).should be_a(Way)
        assigns(:way).line.should == @line 
        assigns(:way).should be_persisted
      end

      it "redirects to the created way" do
        post :create, :line_id => @line.id, :way => valid_attributes
        response.should redirect_to(@line)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved way as @way" do
        Way.any_instance.stub(:save).and_return(false)
        post :create, :line_id => "1", :way => valid_attributes
        assigns(:way).should be_a_new(Way)
      end

      it "re-renders the 'new' template" do
        Way.any_instance.stub(:save).and_return(false)
        post :create, :line_id => "1", :way => valid_attributes
        response.body.should be_blank
      end
    end
  end
  
  describe "DELETE destroy" do
    
    it "destroys the requested way" do
      way = Way.create! valid_attributes
      expect {
        delete :destroy, :id => way.id.to_s
      }.to change(Way, :count).by(-1)
    end

    it "redirects to the way show" do
      way = Way.create! valid_attributes
      delete :destroy, :id => way.id.to_s
      response.should redirect_to(way.line)
    end
  end
  
end