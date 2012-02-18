# encoding: utf-8
require 'acceptance/acceptance_helper'

feature 'Editing an existent line: '  do
  
  before(:each) do
    @line=Factory(:red_line, :transport_id => Factory(:metro).id)
  end
    
  describe "modifying an existing" do
    before(:each) do
      visit edit_line_path(@line)
      sections_menu_should_be_visible
    
      page.should have_content I18n.t('lines.edit.title')
    end  
    
    scenario "should let me update the line registry" do
      fill_in "line_name", :with => "Línea 2"
      fill_in "line_right_terminal", :with => "Tasqueña"
      fill_in "line_left_terminal", :with => "Cuatro Caminos"
    
      click_on I18n.t('actions.save') 
    
      page.should have_content I18n.t('lines.update.messages.saved')
      page.current_path.should == line_path(@line)
      page.should have_content "Línea 2"
      page.should have_content "Cuatro Caminos - Tasqueña"      
    end
  
    scenario "should NOT let me update the line registry if a field is empty" do
      fill_in "line_name", :with => ""
      fill_in "line_right_terminal", :with => ""
      fill_in "line_left_terminal", :with => ""
      
      click_on I18n.t('actions.save')
      page.should have_content I18n.t('lines.update.messages.not_saved')
    end
  end
end