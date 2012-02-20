require 'acceptance/acceptance_helper'

feature 'Editing an existent transport: '  do
  
  before(:each) do
    @metro=Factory(:metro)
  end
    
  describe "modifying an existing" do
    before(:each) do
      visit edit_transport_path(@metro)
      sections_menu_should_be_visible
    
      page.should have_content I18n.t('transports.edit.title')
    end  
    
    scenario "should let save a new transport registry" do
      fill_in "transports_name", :with => "STC Metro DF"
      fill_in "transports_web_page", :with => "www.metro.df.gob.mx"
      fill_in "transports_twitter", :with => "TwitterNuevo"
      select "Subway", :from => "transports_mode"
    
      click_on I18n.t('actions.save') 
    
      page.should have_content I18n.t('transports.update.messages.saved')
      page.current_path.should == transport_path(@metro)
      page.should have_content "STC Metro DF"
      page.should have_content "TwitterNuevo"      
    end
  
    scenario "should NOT let save a new transport registry when name field is empty" do
      fill_in "transports_name", :with => ""
      fill_in "transports_web_page", :with => "www.metro.df.gob.mx"
      fill_in "transports_twitter", :with => "Twitter"
      
      click_on I18n.t('actions.save')
      page.should have_content I18n.t('transports.update.messages.not_saved')
    end
  end
end