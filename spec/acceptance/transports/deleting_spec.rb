require 'acceptance/acceptance_helper'

feature 'Deleting an existent transport: '  do
  
  before(:each) do
    @metro=Factory(:metro)
  end
    
  describe "with one in existence; if I want to destroy it then" do
    before(:each) do
      visit transport_path(@metro)
      sections_menu_should_be_visible
    
      page.should have_content I18n.t('transports.show.title')
    end  
    
    scenario "I have to go to it's details page for delete it" do
      click_on I18n.t('actions.delete')
      page.current_path.should == transports_path
      page.should have_content I18n.t('transports.destroy.messages.done')
      page.should have_content I18n.t('transports.index.no_records')
    end
  end
end