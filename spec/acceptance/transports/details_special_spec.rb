require 'acceptance/acceptance_helper'

feature 'Reviewing the details of a transport: '  do
    
  describe "when visiting the details page for a bike sharing transport mode system" do
    before(:each) do
      @ecobici=Factory(:ecobici)
      visit transport_path(@ecobici)
      sections_menu_should_be_visible
    end  
    
    scenario "should show it's main details" do
      page.should have_content @ecobici.name
      page.should have_content I18n.t('docking_stations.index.count.other', :number => 0)
      
      find_link I18n.t('actions.edit')
      find_link I18n.t('actions.back')
      find_button I18n.t('actions.delete')
    end
    
    scenario "should NOT let add a new bike sharing station with empty fields", :js => true do
      click_on I18n.t('docking_stations.new.title')
      page.current_path.should == new_transport_docking_station_path(@ecobici)
            
      click_on I18n.t('actions.save')
      page.current_path.should == docking_stations_path
      page.should have_content I18n.t('docking_stations.create.messages.not_saved')
    end
    
    scenario "should let me add a new bike sharing station and delete it just after", :js => true do
      
      page.should have_content I18n.t('docking_stations.index.title')
      page.should have_content I18n.t('docking_stations.index.no_records')
      
      click_on I18n.t('docking_stations.new.title')
      page.current_path.should == new_transport_docking_station_path(@ecobici)
      
      page.should have_content I18n.t('docking_stations.new.title')
      page.should have_content @ecobici.name
      
      fill_in "docking_station_name", :with => "P493"
      simulate_click_on_map({:lat => 19.22007620847585, :lon => -99.19376930236814})
            
      click_on I18n.t('actions.save')
      
      page.current_path.should == transport_path(@ecobici)
      page.should have_content I18n.t('docking_stations.create.messages.saved')
      page.should have_content I18n.t('docking_stations.index.title')
      
      page.should have_content "P493"
      
      within("#docking_station-#{DockingStation.last.id}") do
        click_button I18n.t('actions.delete')
      end
      page.driver.browser.switch_to.alert.accept
      
      page.current_path.should == transport_path(@ecobici)
      page.should have_content I18n.t('docking_stations.destroy.messages.done')

      page.should have_content I18n.t('docking_stations.index.no_records')
      
    end
  
  end
  
end