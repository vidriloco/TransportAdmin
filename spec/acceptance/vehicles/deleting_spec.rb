require 'acceptance/acceptance_helper'

feature 'Deleting an existent vehicle: '  do
  
  before(:each) do
    metro=Factory(:metro)
    line=Factory(:red_line, :transport_id => metro.id)
    @vh=Factory(:vehicle, :line_id => line.id)
  end
    
  describe "deleting an existing vehicle" do
    before(:each) do
      visit vehicles_path
      sections_menu_should_be_visible    
    end  
    
    scenario "by clicking on it's delete button", :js => true do
    
      click_on I18n.t('actions.delete') 
      page.driver.browser.switch_to.alert.accept
      
      page.should have_content I18n.t('vehicles.destroy.messages.done')
      page.should have_content I18n.t('vehicles.index.no_records')
    end

  end
end