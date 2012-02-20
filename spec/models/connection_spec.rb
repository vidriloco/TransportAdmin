require 'spec_helper'

describe Connection do

  before(:each) do
    @line_one = Factory(:red_line, :transport_id => Factory(:metro).id)
    @observatorio = Factory(:observatorio, :line => @line_one)
    @line_two = Factory(:red_line, :transport_id => Factory(:metro).id)
    @tacubaya = Factory(:tacubaya, :line => @line_two)
  end
  
  def common_params
    {:one_station_id => @observatorio.id, :another_station_id => @tacubaya.id, :one_line_id => @line_one.id, :another_line_id => @line_two.id}
  end
  
  def common_params_changed
    {:one_station_id => @tacubaya.id, :another_station_id => @observatorio.id, :one_line_id => @line_two.id, :another_line_id => @line_one.id}
  end
  
  it "should generate a humanized list of options for select" do
    Connection.humanized_opts_for(:length).should == { I18n.t('selectable_options.length.short') => 1, I18n.t('selectable_options.length.medium') => 2, I18n.t('selectable_options.length.large') => 3 }
  end

  describe "should NOT let save a new record" do
    it "pointing to the same stations in the same ordering with no double direction set, when a identical one exists" do
      Connection.create common_params
      Connection.new(common_params).save.should be_false
    end
  
    it "pointing to the same stations in different ordering with no double direction set, when a identical one exists" do
      Connection.create(common_params)
      Connection.new(common_params_changed).save.should be_false
    end
  end
  
  describe "should let update an existing record" do
    
    before(:each) do
      @connection = Connection.create(common_params)
    end
    
    it "with a different ordering of stations" do
      @connection.update_attributes(common_params_changed).should be_true
    end
    
    it "with the same ordering of stations" do
      @connection.update_attributes(common_params).should be_true
    end
    
    it "with no changes made" do
      @connection.update_attributes({}).should be_true
    end
    
  end
end

