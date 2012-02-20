# encoding: utf-8
require 'spec_helper'

describe ConnectionsController do

  before(:each) do
    @line = Factory(:red_line, :transport_id => Factory(:metro).id)
    @line_params = {:line_id => @line.id}
  end
  
  describe "GET new" do        
    it "assigns a new connection as @connection" do
      get :new, @line_params
      assigns(:connection).should be_a_new(Connection)
      assigns(:line).should == @line
    end
  end
  
  describe "with valid parameters" do
    
    before(:each) do
      @valid_parameters = {
        :one_station_id => Factory(:observatorio, :line => @line).id, 
        :another_station_id => Factory(:tacubaya, :line => @line).id, 
        :one_line_id => @line.id
      }
    end
    
    describe "POST create" do
      describe "with valid params" do
      
        it "creates a new Connection" do
          expect {
            post :create, :connection => @valid_parameters
          }.to change(Connection, :count).by(1)
        end

        it "assigns a newly created connection as @connection" do
          post :create, :connection => @valid_parameters
          assigns(:connection).should be_a(Connection)
          assigns(:connection).should be_persisted
          assigns(:line).should be_a(Line)
        end

        it "redirects to the created connection" do
          post :create, :connection => @valid_parameters
          response.should redirect_to(@line)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved connection as @connection" do
          Connection.any_instance.stub(:save).and_return(false)
          post :create, :connection => {:one_line_id => @line.id}
          assigns(:connection).should be_a_new(Connection)
          assigns(:line).should be_a(Line)
        end

        it "re-renders the 'new' template" do
          Connection.any_instance.stub(:save).and_return(false)
          post :create, :connection => {}
          response.should render_template("new")
        end
      end
    end
  
    describe "DELETE destroy" do
    
      it "destroys the requested connection" do
        connection = Connection.create! @valid_parameters
        expect {
          delete :destroy, :id => connection.id.to_s
        }.to change(Connection, :count).by(-1)
      end

      it "redirects to the lines connection" do
        connection = Connection.create! @valid_parameters
        delete :destroy, :id => connection.id.to_s
        response.should redirect_to(@line)
      end
    end
  
    describe "GET edit" do
      it "assigns the requested connection as @connection" do
        connection = Connection.create! @valid_parameters
        get :edit, :id => connection.id.to_s, :line_id => @line.id
        assigns(:connection).should eq(connection)
        assigns(:line).should be_a(Line)
      end
    end
    
    
    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested connection" do
          connection = Connection.create! @valid_parameters

          Connection.any_instance.should_receive(:update_attributes).with({"one_line_id" => @line.id.to_s})
          put :update, :id => connection.id, :connection => {"one_line_id" => @line.id}
        end

        it "assigns the requested connection as @connection" do
          connection = Connection.create! @valid_parameters
          put :update, :id => connection.id, :connection => @valid_parameters
          assigns(:connection).should eq(connection)
          assigns(:line).should be_a(Line)
        end

        it "redirects to the connection" do
          connection = Connection.create! @valid_parameters
          put :update, :id => connection.id, :connection => @valid_parameters
          response.should redirect_to(@line)
        end
      end

      describe "with invalid params" do
        it "assigns the connection as @connection" do
          connection = Connection.create! @valid_parameters
          Connection.any_instance.stub(:save).and_return(false)
          put :update, :id => connection.id.to_s, :connection => @valid_parameters
          assigns(:connection).should eq(connection)
        end

        it "re-renders the 'edit' template" do
          connection = Connection.create! @valid_parameters
          Connection.any_instance.stub(:save).and_return(false)
          put :update, :id => connection.id.to_s, :connection => @valid_parameters
          response.should render_template("edit")
        end
      end
    end
    
  end
  
end