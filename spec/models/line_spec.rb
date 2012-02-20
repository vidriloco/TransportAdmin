#encoding: utf-8
require 'spec_helper'

describe Line do
  
  describe "having one line registered" do
    
    before(:each) do
      @line = Factory(:blue_line, :transport_id => Factory(:metro).id)
    end
    
    it "should reply with NO when asked if it's possible to generate the basic traversals" do
      @line.send("can_generate_basic_traversals?").should be_false
    end
    
    describe "having added it's ending stations" do
      
      before(:each) do
        @fs=Factory(:observatorio, :line_id => @line.id)
        @ls=Factory(:station, :name => "Pantitlán", :line_id => @line.id)
      end
      
      it "should reply with YES when asked if it's possible to generate the basic traversals" do
        @line.send("can_generate_basic_traversals?").should be_true
      end
      
      describe "with traversals registered for the line" do
        
        before(:each) do
          @t1= Factory(:traversal, :one_station_id => @fs.id, :another_station_id => @ls.id)
          @t2= Factory(:traversal, :one_station_id => @ls.id, :another_station_id => @fs.id)
        end
        
        it "should retrieve them" do
          @line.send("basic_traversals").should == [@t1, @t2]
        end
      end
      
    end
    
  end
  
end
