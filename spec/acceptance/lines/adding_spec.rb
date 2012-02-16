# encoding: utf-8

require 'acceptance/acceptance_helper'

feature 'Adding a new line: '  do
    
  describe "when visiting the new line form page" do
    before(:each) do
      @metro=Factory(:metro)
      Factory(:ecobici)
      
      visit new_line_path
      sections_menu_should_be_visible
    
      page.should have_content I18n.t('lines.new.title')
      
    end  
    
    scenario "should let save a new line registry and add-remove paths to it", :js => true do
      fill_in "line_name", :with => "Línea 3"
      fill_in "line_name_by_directions", :with => "Indios Verdes - Universidad"
      fill_in "line_color", :with => "#ffffff"
      
      select @metro.name, :from => "line_transport_id"
    
      click_on I18n.t('actions.save') 
    
      page.should have_content I18n.t('lines.create.messages.saved')
      page.current_path.should == line_path(Line.first)
      page.should have_content "STC Metro"
      page.should have_content "Línea 3"
      page.should have_content "Indios Verdes - Universidad"
      
      page.should have_content I18n.t('ways.index.title')
      page.should have_content I18n.t('ways.index.no_records')
      
      page.should have_content I18n.t('ways.new.title')
    end
  
    scenario "should NOT let save a new transport registry when name field is empty" do
      click_on I18n.t('actions.save')
      page.should have_content I18n.t('lines.create.messages.not_saved')
    end
  end
end