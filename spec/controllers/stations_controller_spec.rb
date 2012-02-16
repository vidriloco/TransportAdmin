# encoding: utf-8
require 'spec_helper'

describe StationsController do
  
  def valid_attributes
    Factory.attributes_for(:station)
  end

  describe "GET new" do
    
    describe "with a line agrouper" do
    
      before(:each) do
        @agrouper = Factory(:red_line, :transport_id => Factory(:metro).id)
      end
    
      it "assigns a new station as @station" do
        get :new, :agrouper_id => @agrouper.id
        assigns(:station).should be_a_new(Station)
      end
    
      it "assigns the received line as @line" do
        get :new, :agrouper_id => @agrouper.id
        assigns(:agrouper).should == @agrouper
      end
      
    end
  end

end