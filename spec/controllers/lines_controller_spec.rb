require 'spec_helper'

describe LinesController do

  def valid_attributes
    Factory.attributes_for(:red_line, :transport_id => Factory(:metro).id)
  end

  describe "GET index" do
    
    it "assigns all transports as @transports" do
      transport = Factory(:metrobus)
      get :index
      assigns(:transports).should eq([transport])
    end
    
  end

  describe "GET show" do
    it "assigns the requested line as @line" do
      line = Line.create! valid_attributes
      get :show, :id => line.id.to_s
      assigns(:line).should eq(line)
    end
  end

  describe "GET new" do
    it "assigns a new line as @line" do
      get :new
      assigns(:line).should be_a_new(Line)
    end
  end

  describe "GET edit" do
    it "assigns the requested line as @line" do
      line = Line.create! valid_attributes
      get :edit, :id => line.id.to_s
      assigns(:line).should eq(line)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Line" do
        expect {
          post :create, :line => valid_attributes
        }.to change(Line, :count).by(1)
      end

      it "assigns a newly created line as @line" do
        post :create, :line => valid_attributes
        assigns(:line).should be_a(Line)
        assigns(:line).should be_persisted
      end

      it "redirects to the created line" do
        post :create, :line => valid_attributes
        response.should redirect_to(Line.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved line as @line" do
        Line.any_instance.stub(:save).and_return(false)
        post :create, :line => {}
        assigns(:line).should be_a_new(Line)
      end

      it "re-renders the 'new' template" do
        Line.any_instance.stub(:save).and_return(false)
        post :create, :line => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested line" do
        line = Line.create! valid_attributes

        Line.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => line.id, :line => {'these' => 'params'}
      end

      it "assigns the requested line as @line" do
        line = Line.create! valid_attributes
        put :update, :id => line.id, :line => valid_attributes
        assigns(:line).should eq(line)
      end

      it "redirects to the line" do
        line = Line.create! valid_attributes
        put :update, :id => line.id, :line => valid_attributes
        response.should redirect_to(line)
      end
    end

    describe "with invalid params" do
      it "assigns the line as @line" do
        line = Line.create! valid_attributes
        Line.any_instance.stub(:save).and_return(false)
        put :update, :id => line.id.to_s, :line => {}
        assigns(:line).should eq(line)
      end

      it "re-renders the 'edit' template" do
        line = Line.create! valid_attributes
        Line.any_instance.stub(:save).and_return(false)
        put :update, :id => line.id.to_s, :line => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested line" do
      line = Line.create! valid_attributes
      expect {
        delete :destroy, :id => line.id.to_s
      }.to change(Line, :count).by(-1)
    end

    it "redirects to the lines list" do
      line = Line.create! valid_attributes
      delete :destroy, :id => line.id.to_s
      response.should redirect_to(lines_url)
    end
  end

end
