require 'acceptance/acceptance_helper'

feature 'Editing an existent vehicle: '  do
  
  before(:each) do
    metro=Factory(:metro)
    line=Factory(:red_line, :transport_id => metro.id)
    @vh=Factory(:vehicle, :line_id => line.id)
  end
    
  describe "modifying an existing vehicle" do
    before(:each) do
      visit edit_vehicle_path(@vh)
      sections_menu_should_be_visible
    
      page.should have_content I18n.t('vehicles.edit.title')
    end  
    
    scenario "should let me edit an existent registry" do
      fill_in "vehicle_identifier", :with => "25"
      fill_in "vehicle_description", :with => "One new bus"
    
      click_on I18n.t('actions.save') 
    
      page.should have_content I18n.t('vehicles.update.messages.saved')
      page.current_path.should == vehicles_path
      within("#vehicle-#{@vh.id}") do
        page.should have_content "25"
        page.should have_content "One new bus" 
      end
    end
  
    scenario "should NOT let me update a vehicle registry when identifier field is empty" do
      fill_in "vehicle_identifier", :with => ""
      
      click_on I18n.t('actions.save')
      page.should have_content I18n.t('vehicles.update.messages.not_saved')
    end
  end
end