require 'acceptance/acceptance_helper'

feature 'Adding a new transport: '  do
    
  describe "when visiting the new transport form page" do
    before(:each) do
      visit new_transport_path
      sections_menu_should_be_visible
    
      page.should have_content I18n.t('transports.new.title')
    end  
    
    scenario "should let save a new transport registry" do
      fill_in "transports_name", :with => "STC Metro"
      fill_in "transports_web_page", :with => "www.metro.df.gob.mx"
      fill_in "transports_twitter", :with => "Twitter"
      select "Bike sharing", :from => "transports_mode"
    
      click_on I18n.t('actions.save') 
    
      page.should have_content I18n.t('transports.create.messages.saved')
      page.current_path.should == transport_path(Transport.first)
      page.should have_content "STC Metro"
    end
  
    scenario "should NOT let save a new transport registry when name field is empty" do
      fill_in "transports_web_page", :with => "www.metro.df.gob.mx"
      fill_in "transports_twitter", :with => "Twitter"
      
      click_on I18n.t('actions.save')
      page.should have_content I18n.t('transports.create.messages.not_saved')
    end
  end
end
