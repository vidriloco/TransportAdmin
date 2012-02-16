require 'acceptance/acceptance_helper'

feature 'Reviewing the details of a transport: '  do
    
  describe "when visiting the details page for a bike sharing transport mode system" do
    before(:each) do
      @ecobici=Factory(:ecobici)
      visit transport_path(@ecobici)
      sections_menu_should_be_visible
    
      page.should have_content I18n.t('transports.show.title')
    end  
    
    scenario "should show it's details" do
      page.should have_content @ecobici.name
      page.should have_content @ecobici.twitter
      page.should have_content @ecobici.humanized_mode
      page.should have_content "0 particiones"
      
      find_link I18n.t('actions.edit')
    end
  
  end
  
  describe "when visiting the details page for a subway transport mode system" do
    before(:each) do
      @metro=Factory(:metro)
      visit transport_path(@metro)
      sections_menu_should_be_visible
    
      page.should have_content I18n.t('transports.show.title')
    end  
    
    scenario "should show it's details" do
      page.should have_content @metro.name
      page.should have_content @metro.twitter
      page.should have_content @metro.humanized_mode
      page.should have_content "0 lineas"
      
      find_link I18n.t('actions.edit')
    end
  
  end
end