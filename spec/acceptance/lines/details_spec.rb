# encoding: utf-8

require 'acceptance/acceptance_helper'

feature 'Reviewing the details of a line: '  do
  
  before(:each) do
    @line=Factory(:red_line, :transport_id => Factory(:metro).id)
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
    
    scenario "should let me add stations to the line", :js => true do
      
      page.should have_content I18n.t('stations.index.title')
      page.should have_content I18n.t('stations.index.no_records')
      
      click_on I18n.t('stations.new.title')
      page.current_path.should == new_line_station_path(@line)
      
      page.should have_content I18n.t('stations.new.title')
      page.should have_content @line.transport.name
      page.should have_content @line.name
      page.should have_content @line.name_by_directions
      
      fill_in "station_name", :with => "Observatorio"
      simulate_click_on_map({:lat => 19.42007620847585, :lon => -99.25376930236814})
      
      check "station_is_terminal"
      uncheck "station_has_previous_station"
      
      click_on I18n.t('actions.save')
      
      page.current_path.should == line_path(@line)
      page.should have_content I18n.t('stations.create.messages.saved')
      page.should have_content I18n.t('stations.index.title')
      
      page.should have_content "Observatorio"
      page.should have_content I18n.t("stations.types.terminal")
      find_link I18n.t('actions.edit')
      find_button I18n.t('actions.delete')
    end
    
    scenario "should NOT let me add an station with empty values to the line", :js => true do
      click_on I18n.t('stations.new.title')
      page.current_path.should == new_line_station_path(@line)
      
      click_on I18n.t('actions.save')
      page.current_path.should == stations_path
      page.should have_content I18n.t('stations.create.messages.not_saved')
    end
    
    describe "having an station registered before" do
      
      before(:each) do
        @station_name = "Observatorio"
        register_new_station_with(@station_name)
      end

      scenario "should let me delete it", :js => true do
        visit line_path(@line)
        
        page.should have_content @station_name
        click_button I18n.t('actions.delete')
        page.driver.browser.switch_to.alert.accept
        page.current_path.should == line_path(@line)
        page.should have_content I18n.t('stations.destroy.messages.done')
        
        page.should have_content I18n.t('stations.index.no_records')
      end
      
      scenario "should let me change it's name", :js => true do
        visit line_path(@line)
        
        page.should have_content @station_name
        click_link I18n.t('actions.edit')
        page.current_path.should == edit_station_path(Station.first)
        
        fill_in "station_name", :with => "Insurgentes"
        uncheck "station_is_terminal"
        
        click_on I18n.t('actions.save')
        page.should have_content I18n.t('stations.update.messages.saved')
        
        page.should have_content "Insurgentes"
        page.should have_content I18n.t("stations.types.non_terminal")
      end
      
      scenario "should let me change it's coordinates", :js => true do
        visit line_path(@line)
        
        page.should have_content @station_name
        click_link I18n.t('actions.edit')
        page.current_path.should == edit_station_path(Station.first)
        simulate_click_on_map({:lat => 19.22007620847585, :lon => -99.15376930236814})
        click_on I18n.t('actions.save')
        page.should have_content I18n.t('stations.update.messages.saved')
        
      end
      
    end
   
  end
end

def register_new_station_with(name)
  click_on I18n.t('stations.new.title')
  page.current_path.should == new_line_station_path(@line)
  
  page.should have_content I18n.t('stations.new.title')
  page.should have_content @line.transport.name
  page.should have_content @line.name
  page.should have_content @line.name_by_directions
  
  fill_in "station_name", :with => name
  simulate_click_on_map({:lat => 19.42007620847585, :lon => -99.25376930236814})
  
  check "station_is_terminal"
  uncheck "station_has_previous_station"
  
  click_on I18n.t('actions.save')
end