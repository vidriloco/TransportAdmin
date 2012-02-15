require 'acceptance/acceptance_helper'

feature 'Deleting an existent line: '  do
  
  before(:each) do
    @line=Factory(:red_line, :transport_id => Factory(:metro).id)
  end
    
  describe "with one in existence; if I want to destroy it then" do
    before(:each) do
      visit lines_path
      sections_menu_should_be_visible
    
      page.should have_content I18n.t('lines.index.title')
    end  
    
    scenario "I can delete it from the listing page", :js => true do
      within("#line-#{@line.id}") do
        click_on I18n.t('actions.delete')
      end
      page.driver.browser.switch_to.alert.accept
      
      page.current_path.should == lines_path
      page.should have_content I18n.t('lines.destroy.messages.done')
      page.should have_content I18n.t('lines.index.no_records')
    end
  end
end