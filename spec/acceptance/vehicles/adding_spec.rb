require 'acceptance/acceptance_helper'

feature 'Adding a new vehicle: '  do
    
  before(:each) do
    @metro = Factory(:metro)
    @linea_1 = Factory(:red_line, :transport_id => @metro.id)
  end
    
    
  describe "Registering a new vechicle to a line" do
    
    before(:each) do
      visit new_vehicle_path
      sections_menu_should_be_visible
    
      page.should have_content I18n.t('vehicles.new.title')
    end  
    
    scenario "should let save a new vehicle registry" do
      fill_in "vehicle_identifier", :with => "24"
      fill_in "vehicle_description", :with => "The blue low floor mercedes-benz bus"
      select @linea_1.name, :from => "vehicle_line_id"
    
      click_on I18n.t('actions.save') 
    
      page.should have_content I18n.t('vehicles.create.messages.saved')
      page.current_path.should == vehicles_path
      
      page.should have_content "24"
      
      page.should have_content "The blue low floor mercedes-benz bus"
      
      page.should have_content I18n.t('activerecord.attributes.vehicle.line')
      page.should have_content @linea_1.line_transport
    end
  
    scenario "should NOT let save a new vehicle registry when identifier field is not provided" do
      
      click_on I18n.t('actions.save')
      page.should have_content I18n.t('vehicles.create.messages.not_saved')
    end
    
  end
end