# encoding: utf-8

require 'acceptance/acceptance_helper'

feature 'Reviewing the details of a line: '  do
  
  before(:each) do
    @line=Factory(:red_line, :transport_id => Factory(:metro))
  end
    
  describe "when visiting the details page for a subway transport mode system" do
    before(:each) do
      visit line_path(@line)
      sections_menu_should_be_visible 
    end  
    
    scenario "should show it's main details" do
      page.should have_content @line.transport.name
      page.should have_content @line.name
      page.should have_content @line.name_by_directions
      
      find_link I18n.t('actions.edit')
      find_link I18n.t('actions.back')
    end
    
    scenario "should let me add a new way to the line", :js => true do
      click_on I18n.t('ways.new.title')
      fill_in "way_content", :with => "-99.13955021914663,19.34375187346597,0 -99.14146374212993,19.34383717087054,0"
      fill_in "way_description", :with => "Curva conectando x punto con y punto"
      click_on I18n.t('actions.add')
      
      page.should have_content I18n.t('ways.create.messages.saved')
      page.current_path.should == line_path(Line.first)
      page.should_not have_content I18n.t('ways.index.no_records')
      
      page.should have_content "Vector de coordenadas con 2 elementos"
      page.should have_content "Curva conectando x punto con y punto"
      click_on I18n.t('actions.delete')
      
      page.driver.browser.switch_to.alert.accept
      
      page.current_path.should == line_path(Line.first)
      page.should have_content I18n.t('ways.destroy.messages.done')
      page.should_not have_content "Curva conectando x punto con y punto"
      page.should have_content I18n.t('ways.index.no_records')
    end
    
    scenario "should NOT let me add empty paths to the line", :js => true do      
      click_on I18n.t('ways.new.title')
      fill_in "way_content", :with => ""
      fill_in "way_description", :with => ""
      click_on I18n.t('actions.add')
      page.should have_content I18n.t('ways.create.messages.not_saved')
    end
    
    scenario "should let me add stations to the line" do
      
      page.should have_content I18n.t('stations.index.title')
      page.should have_content I18n.t('stations.index.no_records')
      
      click_on I18n.t('stations.new.title')
      page.current_path.should == new_agrouper_station_path(@line)
      
      page.should have_content I18n.t('stations.new.title')
      page.should have_content @line.transport.name
      page.should have_content @line.name
      page.should have_content @line.name_by_directions
      
      fill_in "station_name", :with => "Observatorio"
      fill_in "station_lon", :with => "-99.20052096133151"
      fill_in "station_lat", :with => "19.39816903360576"
      
      uncheck "has_previous_station"
      
      click_on I18n.t('actions.save')
    end
   
  end
end